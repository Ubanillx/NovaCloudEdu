#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
将 json-full 目录下的 JSON 文件转换为 PostgreSQL INSERT 语句
用于导入到 daily_word 表
"""

import json
import os
from datetime import datetime, timedelta
from pathlib import Path

# 配置
ADMIN_ID = 1996386801555701762
JSON_DIR = Path(__file__).parent / "json_original" / "json-full"
OUTPUT_FILE = Path(__file__).parent / "daily_word_import_full.sql"

# 分类到难度的映射
# 难度等级：1-简单，2-中等，3-困难
CATEGORY_DIFFICULTY_MAP = {
    # 小学 - 简单
    "PEPXiaoXue3": 1,
    "PEPXiaoXue4": 1,
    "PEPXiaoXue5": 1,
    "PEPXiaoXue6": 1,
    # 初中 - 简单到中等
    "PEPChuZhong7": 1,
    "PEPChuZhong8": 1,
    "PEPChuZhong9": 2,
    "ChuZhong": 1,
    "ChuZhongluan": 1,
    "WaiYanSheChuZhong": 1,
    # 高中 - 中等
    "PEPGaoZhong": 2,
    "GaoZhong": 2,
    "GaoZhongluan": 2,
    "BeiShiGaoZhong": 2,
    # 四级 - 中等
    "CET4": 2,
    "CET4luan": 2,
    "Level4": 2,
    "Level4luan": 2,
    # 六级 - 中等到困难
    "CET6": 2,
    "CET6luan": 2,
    # 考研 - 困难
    "KaoYan": 3,
    "KaoYanluan": 3,
    # 专八 - 困难
    "Level8": 3,
    "Level8luan": 3,
    # 托福/雅思/GRE/GMAT/SAT/BEC - 困难
    "TOEFL": 3,
    "IELTS": 3,
    "IELTSluan": 3,
    "GRE": 3,
    "GMAT": 3,
    "GMATluan": 3,
    "SAT": 3,
    "BEC": 3,
}

# 分类名称映射（更友好的显示名称）
CATEGORY_NAME_MAP = {
    "PEPXiaoXue3": "小学三年级",
    "PEPXiaoXue4": "小学四年级",
    "PEPXiaoXue5": "小学五年级",
    "PEPXiaoXue6": "小学六年级",
    "PEPChuZhong7": "初中七年级",
    "PEPChuZhong8": "初中八年级",
    "PEPChuZhong9": "初中九年级",
    "ChuZhong": "初中",
    "ChuZhongluan": "初中(乱序)",
    "WaiYanSheChuZhong": "外研社初中",
    "PEPGaoZhong": "高中",
    "GaoZhong": "高中",
    "GaoZhongluan": "高中(乱序)",
    "BeiShiGaoZhong": "北师高中",
    "CET4": "四级",
    "CET4luan": "四级(乱序)",
    "Level4": "专四",
    "Level4luan": "专四(乱序)",
    "CET6": "六级",
    "CET6luan": "六级(乱序)",
    "KaoYan": "考研",
    "KaoYanluan": "考研(乱序)",
    "Level8": "专八",
    "Level8luan": "专八(乱序)",
    "TOEFL": "托福",
    "IELTS": "雅思",
    "IELTSluan": "雅思(乱序)",
    "GRE": "GRE",
    "GMAT": "GMAT",
    "GMATluan": "GMAT(乱序)",
    "SAT": "SAT",
    "BEC": "BEC商务英语",
}


def get_category_prefix(book_id: str) -> str:
    """从bookId中提取分类前缀"""
    # 移除末尾的 _数字
    parts = book_id.rsplit("_", 1)
    return parts[0] if len(parts) > 1 else book_id


def get_difficulty(book_id: str) -> int:
    """根据bookId获取难度等级"""
    prefix = get_category_prefix(book_id)
    return CATEGORY_DIFFICULTY_MAP.get(prefix, 2)  # 默认中等难度


def get_category_name(book_id: str) -> str:
    """根据bookId获取分类名称"""
    prefix = get_category_prefix(book_id)
    return CATEGORY_NAME_MAP.get(prefix, prefix)


def escape_sql_string(s: str) -> str:
    """转义SQL字符串中的特殊字符"""
    if s is None:
        return ""
    return s.replace("'", "''").replace("\\", "\\\\")


def extract_word_data(word_obj: dict) -> dict:
    """从JSON对象中提取单词数据"""
    result = {
        "word": "",
        "pronunciation": "",
        "translation": "",
        "example": "",
        "example_translation": "",
        "notes": {},
    }
    
    # 基本信息
    result["word"] = word_obj.get("headWord", "")
    book_id = word_obj.get("bookId", "")
    
    # 获取content
    content = word_obj.get("content", {})
    word_content = content.get("word", {})
    inner_content = word_content.get("content", {})
    
    # 音标 - 优先使用美式音标
    usphone = inner_content.get("usphone", "")
    ukphone = inner_content.get("ukphone", "")
    result["pronunciation"] = usphone if usphone else ukphone
    
    # 翻译 - 从trans数组中提取
    trans_list = inner_content.get("trans", [])
    translations = []
    for t in trans_list:
        pos = t.get("pos", "")
        tran_cn = t.get("tranCn", "")
        if pos and tran_cn:
            translations.append(f"{pos}. {tran_cn}")
        elif tran_cn:
            translations.append(tran_cn)
    result["translation"] = "; ".join(translations) if translations else ""
    
    # 例句
    sentence_obj = inner_content.get("sentence", {})
    sentences = sentence_obj.get("sentences", [])
    if sentences:
        first_sentence = sentences[0]
        result["example"] = first_sentence.get("sContent", "")
        result["example_translation"] = first_sentence.get("sCn", "")
    
    # 额外信息存入notes
    notes = {}
    
    # 同义词
    syno_obj = inner_content.get("syno", {})
    synos = syno_obj.get("synos", [])
    if synos:
        syno_list = []
        for s in synos:
            hwds = s.get("hwds", [])
            words = [h.get("w", "") for h in hwds if h.get("w")]
            if words:
                syno_list.extend(words)
        if syno_list:
            notes["synonyms"] = syno_list[:10]  # 限制数量
    
    # 短语
    phrase_obj = inner_content.get("phrase", {})
    phrases = phrase_obj.get("phrases", [])
    if phrases:
        phrase_list = []
        for p in phrases[:5]:  # 限制数量
            phrase_list.append({
                "phrase": p.get("pContent", ""),
                "meaning": p.get("pCn", "")
            })
        if phrase_list:
            notes["phrases"] = phrase_list
    
    # 记忆方法
    rem_method = inner_content.get("remMethod", {})
    if rem_method.get("val"):
        notes["memory_tip"] = rem_method.get("val", "")
    
    # 同根词
    rel_word = inner_content.get("relWord", {})
    rels = rel_word.get("rels", [])
    if rels:
        rel_list = []
        for r in rels[:3]:  # 限制数量
            words = r.get("words", [])
            for w in words[:3]:
                rel_list.append({
                    "word": w.get("hwd", ""),
                    "meaning": w.get("tran", "")
                })
        if rel_list:
            notes["related_words"] = rel_list
    
    # 英文释义
    if trans_list:
        eng_defs = []
        for t in trans_list:
            tran_other = t.get("tranOther", "")
            if tran_other:
                eng_defs.append(tran_other)
        if eng_defs:
            notes["english_definitions"] = eng_defs
    
    # 更多例句
    if len(sentences) > 1:
        more_examples = []
        for s in sentences[1:4]:  # 限制数量
            more_examples.append({
                "en": s.get("sContent", ""),
                "cn": s.get("sCn", "")
            })
        if more_examples:
            notes["more_examples"] = more_examples
    
    result["notes"] = notes
    result["book_id"] = book_id
    
    return result


def generate_insert_sql(word_data: dict, publish_date: str) -> str:
    """生成INSERT SQL语句"""
    word = escape_sql_string(word_data["word"])
    pronunciation = escape_sql_string(word_data["pronunciation"])
    translation = escape_sql_string(word_data["translation"])
    example = escape_sql_string(word_data["example"])
    example_translation = escape_sql_string(word_data["example_translation"])
    book_id = word_data["book_id"]
    category = escape_sql_string(get_category_name(book_id))
    difficulty = get_difficulty(book_id)
    notes = escape_sql_string(json.dumps(word_data["notes"], ensure_ascii=False)) if word_data["notes"] else ""
    
    # 如果翻译为空，跳过
    if not translation:
        return None
    
    sql = f"""INSERT INTO daily_word (word, pronunciation, translation, example, example_translation, difficulty, category, notes, publish_date, admin_id)
VALUES ('{word}', '{pronunciation}', '{translation}', '{example}', '{example_translation}', {difficulty}, '{category}', '{notes}', '{publish_date}', {ADMIN_ID});"""
    
    return sql


def process_json_file(json_path: Path) -> list:
    """处理单个JSON文件，返回SQL语句列表"""
    sql_statements = []
    
    try:
        with open(json_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except Exception as e:
        print(f"Error reading {json_path}: {e}")
        return sql_statements
    
    # 确保data是列表
    if isinstance(data, dict):
        data = [data]
    
    for word_obj in data:
        try:
            word_data = extract_word_data(word_obj)
            if word_data["word"] and word_data["translation"]:
                sql_statements.append(word_data)
        except Exception as e:
            print(f"Error processing word in {json_path}: {e}")
            continue
    
    return sql_statements


def main():
    """主函数"""
    print(f"开始处理 JSON 文件...")
    print(f"JSON 目录: {JSON_DIR}")
    print(f"输出文件: {OUTPUT_FILE}")
    
    all_word_data = []
    
    # 遍历所有JSON文件
    json_files = sorted(JSON_DIR.glob("*.json"))
    print(f"找到 {len(json_files)} 个 JSON 文件")
    
    for json_file in json_files:
        print(f"处理: {json_file.name}")
        word_data_list = process_json_file(json_file)
        all_word_data.extend(word_data_list)
        print(f"  - 提取了 {len(word_data_list)} 个单词")
    
    print(f"\n总共提取了 {len(all_word_data)} 个单词")
    
    # 生成SQL文件
    # 使用当前日期作为起始发布日期
    start_date = datetime.now().date()
    
    with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
        f.write("-- 自动生成的 daily_word 导入脚本\n")
        f.write(f"-- 生成时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"-- 单词总数: {len(all_word_data)}\n")
        f.write(f"-- Admin ID: {ADMIN_ID}\n\n")
        
        # 按分类分组写入
        current_category = None
        word_count = 0
        
        for i, word_data in enumerate(all_word_data):
            category = get_category_name(word_data["book_id"])
            
            # 写入分类注释
            if category != current_category:
                if current_category is not None:
                    f.write(f"\n-- {current_category} 完成，共 {word_count} 个单词\n\n")
                current_category = category
                word_count = 0
                f.write(f"\n-- ========== {category} ==========\n")
            
            # 计算发布日期（每天发布一定数量的单词）
            publish_date = (start_date + timedelta(days=i // 20)).strftime('%Y-%m-%d')
            
            sql = generate_insert_sql(word_data, publish_date)
            if sql:
                f.write(sql + "\n")
                word_count += 1
        
        if current_category:
            f.write(f"\n-- {current_category} 完成，共 {word_count} 个单词\n")
    
    print(f"\nSQL 文件已生成: {OUTPUT_FILE}")
    print("完成!")


if __name__ == "__main__":
    main()
