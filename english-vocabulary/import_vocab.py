#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
一键导入 english-vocabulary/json/ 下的 7 个词库到 Docker postgres 的 daily_word 表

用法:
    python3 import_vocab.py              # 默认连接 nova-postgres 容器
    python3 import_vocab.py --dry-run    # 只生成 SQL 文件，不实际导入
"""

import json
import subprocess
import sys
from datetime import date
from pathlib import Path

# ── 配置 ─────────────────────────────────────────────
DOCKER_CONTAINER = "nova-postgres"
DB_USER = "nova"
DB_NAME = "novacloudedu"
BATCH_SIZE = 500          # 每批插入条数

JSON_DIR = Path(__file__).parent / "json"

# 文件名 → (category, difficulty)
FILE_META = {
    "1-初中-顺序.json":  ("初中", 1),
    "2-高中-顺序.json":  ("高中", 2),
    "3-CET4-顺序.json":  ("四级", 2),
    "4-CET6-顺序.json":  ("六级", 2),
    "5-考研-顺序.json":  ("考研", 3),
    "6-托福-顺序.json":  ("托福", 3),
    "7-SAT-顺序.json":   ("SAT",  3),
}
# ─────────────────────────────────────────────────────


def run_psql(sql: str) -> subprocess.CompletedProcess:
    """通过 docker exec 在容器内执行 psql"""
    return subprocess.run(
        ["docker", "exec", "-i", DOCKER_CONTAINER,
         "psql", "-U", DB_USER, "-d", DB_NAME, "-v", "ON_ERROR_STOP=1"],
        input=sql.encode("utf-8"),
        capture_output=True,
    )


def get_admin_id() -> int:
    result = run_psql("SELECT id FROM \"user\" WHERE user_account='admin' LIMIT 1;")
    if result.returncode != 0:
        print("❌ 无法连接 Docker postgres:", result.stderr.decode())
        sys.exit(1)
    # 输出形如:
    #  id
    # --------------------
    #  1
    # (1 row)
    for line in result.stdout.decode().splitlines():
        line = line.strip()
        if line and line.isdigit():
            return int(line)
    print("❌ 未找到 admin 用户，请先确保种子数据已导入")
    sys.exit(1)


def escape(s: str) -> str:
    """SQL 字符串转义（单引号加倍）"""
    return s.replace("'", "''")


def build_translation(translations: list) -> str:
    """将 translations 列表合并为一个字符串，如 'n. 能力; v. 能干'"""
    parts = []
    for t in translations:
        typ = t.get("type", "").strip()
        trans = t.get("translation", "").strip()
        if typ:
            parts.append(f"{typ}. {trans}")
        else:
            parts.append(trans)
    return "; ".join(parts)


def build_notes(phrases: list) -> str:
    """将 phrases 列表序列化为 JSON 字符串"""
    if not phrases:
        return ""
    return json.dumps(phrases, ensure_ascii=False)


def audio_url(word: str, kind: str) -> str:
    """有道词典发音 URL，kind='us'→type=2，'uk'→type=1"""
    t = "2" if kind == "us" else "1"
    return f"https://dict.youdao.com/dictvoice?audio={word}&type={t}"


def generate_insert_batch(rows: list) -> str:
    """生成一个 INSERT … VALUES … ON CONFLICT DO NOTHING 语句"""
    values = []
    for r in rows:
        values.append(
            f"('{escape(r['word'])}', "
            f"'{escape(r['pronunciation_us'])}', "
            f"'{escape(r['pronunciation_uk'])}', "
            f"'{escape(r['audio_url_us'])}', "
            f"'{escape(r['audio_url_uk'])}', "
            f"'{escape(r['translation'])}', "
            f"NULL, NULL, "                      # example, example_translation
            f"{r['difficulty']}, "
            f"'{escape(r['category'])}', "
            f"'{escape(r['notes'])}', "
            f"'{r['publish_date']}', "
            f"{r['admin_id']})"
        )
    sql = (
        "INSERT INTO daily_word "
        "(word, pronunciation_us, pronunciation_uk, audio_url_us, audio_url_uk, "
        "translation, example, example_translation, difficulty, category, notes, "
        "publish_date, admin_id) VALUES\n"
        + ",\n".join(values)
        + "\nON CONFLICT (word, category) DO NOTHING;\n"
    )
    return sql


def import_file(filepath: Path, category: str, difficulty: int,
                admin_id: int, dry_run: bool,
                out_file=None) -> int:
    """
    导入单个 JSON 文件，返回导入行数。
    """
    print(f"\n📂 {filepath.name}  category={category}  difficulty={difficulty}")
    data = json.loads(filepath.read_text(encoding="utf-8"))

    today = str(date.today())
    batch = []
    total = 0

    for entry in data:
        word = entry.get("word", "").strip()
        if not word:
            continue

        translations = entry.get("translations", [])
        phrases = entry.get("phrases", [])

        row = {
            "word":             word,
            "pronunciation_us": "",
            "pronunciation_uk": "",
            "audio_url_us":     audio_url(word, "us"),
            "audio_url_uk":     audio_url(word, "uk"),
            "translation":      build_translation(translations),
            "difficulty":       difficulty,
            "category":         category,
            "notes":            build_notes(phrases),
            "publish_date":     today,
            "admin_id":         admin_id,
        }
        batch.append(row)

        if len(batch) >= BATCH_SIZE:
            sql = generate_insert_batch(batch)
            if dry_run:
                out_file.write(sql)
            else:
                result = run_psql(sql)
                if result.returncode != 0:
                    print("  ❌ 批量插入失败:", result.stderr.decode()[:200])
            total += len(batch)
            print(f"  ✔ {total}/{len(data)}", end="\r")
            batch = []

    if batch:
        sql = generate_insert_batch(batch)
        if dry_run:
            out_file.write(sql)
        else:
            result = run_psql(sql)
            if result.returncode != 0:
                print("  ❌ 批量插入失败:", result.stderr.decode()[:200])
        total += len(batch)

    print(f"  ✔ {total}/{len(data)} 完成")
    return total


def main():
    dry_run = "--dry-run" in sys.argv
    output_sql = Path(__file__).parent / "vocab_import.sql"

    print("=" * 55)
    print("  NovaCloudEdu 英语词库一键导入工具")
    print("=" * 55)

    if dry_run:
        print("⚠️  Dry-run 模式：只生成 SQL 文件，不实际导入")
        admin_id = 1
    else:
        print("🔍 查询 admin 用户 ID …")
        admin_id = get_admin_id()
        print(f"   admin_id = {admin_id}")

    grand_total = 0

    out_file = open(output_sql, "w", encoding="utf-8") if dry_run else None

    for filename, (category, difficulty) in FILE_META.items():
        filepath = JSON_DIR / filename
        if not filepath.exists():
            print(f"⚠️  文件不存在，跳过: {filepath}")
            continue
        count = import_file(
            filepath, category, difficulty, admin_id,
            dry_run, out_file
        )
        grand_total += count

    if out_file:
        out_file.close()
        print(f"\n✅ SQL 已写入 {output_sql}")
    else:
        print(f"\n✅ 全部完成！共导入 {grand_total:,} 条词汇")

    # 验证
    if not dry_run:
        result = run_psql("SELECT category, COUNT(*) FROM daily_word GROUP BY category ORDER BY category;")
        if result.returncode == 0:
            print("\n📊 当前 daily_word 各分类统计：")
            print(result.stdout.decode())


if __name__ == "__main__":
    main()
