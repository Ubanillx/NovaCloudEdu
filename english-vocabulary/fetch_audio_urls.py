#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
抓取单词发音URL的脚本
使用多个开源词典API获取美式和英式发音

支持的发音源：
1. 有道词典 API
2. 金山词霸 API  
3. Forvo API (需要API Key)
4. Google Translate TTS
"""

import json
import urllib.parse
from pathlib import Path
from typing import Optional, Tuple

# 配置
JSON_DIR = Path(__file__).parent / "json_original" / "json-full"
OUTPUT_FILE = Path(__file__).parent / "daily_word_import_with_audio.sql"
ADMIN_ID = 1996386801555701762


def get_youdao_audio_url(word: str) -> Tuple[Optional[str], Optional[str]]:
    """
    有道词典发音URL
    type=1 英式发音, type=2 美式发音
    """
    encoded_word = urllib.parse.quote(word)
    us_url = f"https://dict.youdao.com/dictvoice?audio={encoded_word}&type=2"
    uk_url = f"https://dict.youdao.com/dictvoice?audio={encoded_word}&type=1"
    return us_url, uk_url


def get_iciba_audio_url(word: str) -> Tuple[Optional[str], Optional[str]]:
    """
    金山词霸发音URL (备用)
    """
    encoded_word = urllib.parse.quote(word)
    # 金山词霸的发音URL格式
    us_url = f"https://www.iciba.com/word?w={encoded_word}"
    uk_url = f"https://www.iciba.com/word?w={encoded_word}"
    return us_url, uk_url


def get_google_tts_url(word: str, lang: str = "en-US") -> str:
    """
    Google TTS URL (可能需要代理)
    lang: en-US 美式, en-GB 英式
    """
    encoded_word = urllib.parse.quote(word)
    return f"https://translate.google.com/translate_tts?ie=UTF-8&q={encoded_word}&tl={lang}&client=tw-ob"


def get_audio_urls(word: str) -> Tuple[str, str]:
    """
    获取单词的美式和英式发音URL
    优先使用有道词典（稳定可靠）
    """
    return get_youdao_audio_url(word)


# 分类到难度的映射
CATEGORY_DIFFICULTY_MAP = {
    "PEPXiaoXue3": 1, "PEPXiaoXue4": 1, "PEPXiaoXue5": 1, "PEPXiaoXue6": 1,
    "PEPChuZhong7": 1, "PEPChuZhong8": 1, "PEPChuZhong9": 2,
    "ChuZhong": 1, "ChuZhongluan": 1, "WaiYanSheChuZhong": 1,
    "PEPGaoZhong": 2, "GaoZhong": 2, "GaoZhongluan": 2, "BeiShiGaoZhong": 2,
    "CET4": 2, "CET4luan": 2, "Level4": 2, "Level4luan": 2,
    "CET6": 2, "CET6luan": 2,
    "KaoYan": 3, "KaoYanluan": 3,
    "Level8": 3, "Level8luan": 3,
    "TOEFL": 3, "IELTS": 3, "IELTSluan": 3,
    "GRE": 3, "GMAT": 3, "GMATluan": 3, "SAT": 3, "BEC": 3,
}

CATEGORY_NAME_MAP = {
    "PEPXiaoXue3": "小学三年级", "PEPXiaoXue4": "小学四年级",
    "PEPXiaoXue5": "小学五年级", "PEPXiaoXue6": "小学六年级",
    "PEPChuZhong7": "初中七年级", "PEPChuZhong8": "初中八年级",
    "PEPChuZhong9": "初中九年级",
    "ChuZhong": "初中", "ChuZhongluan": "初中(乱序)",
    "WaiYanSheChuZhong": "外研社初中",
    "PEPGaoZhong": "高中", "GaoZhong": "高中", "GaoZhongluan": "高中(乱序)",
    "BeiShiGaoZhong": "北师高中",
    "CET4": "四级", "CET4luan": "四级(乱序)",
    "Level4": "专四", "Level4luan": "专四(乱序)",
    "CET6": "六级", "CET6luan": "六级(乱序)",
    "KaoYan": "考研", "KaoYanluan": "考研(乱序)",
    "Level8": "专八", "Level8luan": "专八(乱序)",
    "TOEFL": "托福", "IELTS": "雅思", "IELTSluan": "雅思(乱序)",
    "GRE": "GRE", "GMAT": "GMAT", "GMATluan": "GMAT(乱序)",
    "SAT": "SAT", "BEC": "BEC商务英语",
}


def get_category_prefix(book_id: str) -> str:
    parts = book_id.rsplit("_", 1)
    return parts[0] if len(parts) > 1 else book_id


def get_difficulty(book_id: str) -> int:
    prefix = get_category_prefix(book_id)
    return CATEGORY_DIFFICULTY_MAP.get(prefix, 2)


def get_category_name(book_id: str) -> str:
    prefix = get_category_prefix(book_id)
    return CATEGORY_NAME_MAP.get(prefix, prefix)


def escape_sql_string(s: str) -> str:
    if s is None:
        return ""
    return s.replace("'", "''").replace("\\", "\\\\")


def extract_word_data(word_obj: dict) -> dict:
    """从JSON对象中提取单词数据，包含发音URL"""
    result = {
        "word": "",
        "pronunciation_us": "",
        "pronunciation_uk": "",
        "audio_url_us": "",
        "audio_url_uk": "",
        "translation": "",
        "example": "",
        "example_translation": "",
        "notes": {},
    }
    
    result["word"] = word_obj.get("headWord", "")
    book_id = word_obj.get("bookId", "")
    
    content = word_obj.get("content", {})
    word_content = content.get("word", {})
    inner_content = word_content.get("content", {})
    
    # 音标
    result["pronunciation_us"] = inner_content.get("usphone", "")
    result["pronunciation_uk"] = inner_content.get("ukphone", "")
    
    # 获取发音URL
    if result["word"]:
        audio_us, audio_uk = get_audio_urls(result["word"])
        result["audio_url_us"] = audio_us or ""
        result["audio_url_uk"] = audio_uk or ""
    
    # 翻译
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
            notes["synonyms"] = syno_list[:10]
    
    phrase_obj = inner_content.get("phrase", {})
    phrases = phrase_obj.get("phrases", [])
    if phrases:
        phrase_list = []
        for p in phrases[:5]:
            phrase_list.append({
                "phrase": p.get("pContent", ""),
                "meaning": p.get("pCn", "")
            })
        if phrase_list:
            notes["phrases"] = phrase_list
    
    rem_method = inner_content.get("remMethod", {})
    if rem_method.get("val"):
        notes["memory_tip"] = rem_method.get("val", "")
    
    rel_word = inner_content.get("relWord", {})
    rels = rel_word.get("rels", [])
    if rels:
        rel_list = []
        for r in rels[:3]:
            words = r.get("words", [])
            for w in words[:3]:
                rel_list.append({
                    "word": w.get("hwd", ""),
                    "meaning": w.get("tran", "")
                })
        if rel_list:
            notes["related_words"] = rel_list
    
    if trans_list:
        eng_defs = []
        for t in trans_list:
            tran_other = t.get("tranOther", "")
            if tran_other:
                eng_defs.append(tran_other)
        if eng_defs:
            notes["english_definitions"] = eng_defs
    
    if len(sentences) > 1:
        more_examples = []
        for s in sentences[1:4]:
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
    """生成INSERT SQL语句（包含发音URL）"""
    word = escape_sql_string(word_data["word"])
    pronunciation_us = escape_sql_string(word_data["pronunciation_us"])
    pronunciation_uk = escape_sql_string(word_data["pronunciation_uk"])
    audio_url_us = escape_sql_string(word_data["audio_url_us"])
    audio_url_uk = escape_sql_string(word_data["audio_url_uk"])
    translation = escape_sql_string(word_data["translation"])
    example = escape_sql_string(word_data["example"])
    example_translation = escape_sql_string(word_data["example_translation"])
    book_id = word_data["book_id"]
    category = escape_sql_string(get_category_name(book_id))
    difficulty = get_difficulty(book_id)
    notes = escape_sql_string(json.dumps(word_data["notes"], ensure_ascii=False)) if word_data["notes"] else ""
    
    if not translation:
        return None
    
    sql = f"""INSERT INTO daily_word (word, pronunciation_us, pronunciation_uk, audio_url_us, audio_url_uk, translation, example, example_translation, difficulty, category, notes, publish_date, admin_id)
VALUES ('{word}', '{pronunciation_us}', '{pronunciation_uk}', '{audio_url_us}', '{audio_url_uk}', '{translation}', '{example}', '{example_translation}', {difficulty}, '{category}', '{notes}', '{publish_date}', {ADMIN_ID});"""
    
    return sql


def process_json_file(json_path: Path) -> list:
    """处理单个JSON文件"""
    sql_statements = []
    
    try:
        with open(json_path, 'r', encoding='utf-8') as f:
            data = json.load(f)
    except Exception as e:
        print(f"Error reading {json_path}: {e}")
        return sql_statements
    
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
    from datetime import datetime, timedelta
    
    print(f"开始处理 JSON 文件（包含发音URL）...")
    print(f"JSON 目录: {JSON_DIR}")
    print(f"输出文件: {OUTPUT_FILE}")
    
    all_word_data = []
    
    json_files = sorted(JSON_DIR.glob("*.json"))
    print(f"找到 {len(json_files)} 个 JSON 文件")
    
    for json_file in json_files:
        print(f"处理: {json_file.name}")
        word_data_list = process_json_file(json_file)
        all_word_data.extend(word_data_list)
        print(f"  - 提取了 {len(word_data_list)} 个单词")
    
    print(f"\n总共提取了 {len(all_word_data)} 个单词")
    
    start_date = datetime.now().date()
    
    with open(OUTPUT_FILE, 'w', encoding='utf-8') as f:
        f.write("-- 自动生成的 daily_word 导入脚本（包含发音URL）\n")
        f.write(f"-- 生成时间: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n")
        f.write(f"-- 单词总数: {len(all_word_data)}\n")
        f.write(f"-- Admin ID: {ADMIN_ID}\n")
        f.write("-- 发音源: 有道词典 API\n\n")
        
        current_category = None
        word_count = 0
        
        for i, word_data in enumerate(all_word_data):
            category = get_category_name(word_data["book_id"])
            
            if category != current_category:
                if current_category is not None:
                    f.write(f"\n-- {current_category} 完成，共 {word_count} 个单词\n\n")
                current_category = category
                word_count = 0
                f.write(f"\n-- ========== {category} ==========\n")
            
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
