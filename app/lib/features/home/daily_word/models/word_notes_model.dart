import 'dart:convert';

/// 单词笔记模型
/// 解析notes字段的JSON数据
class WordNotes {
  final List<String>? synonyms;
  final List<RelatedWord>? relatedWords;
  final List<String>? englishDefinitions;
  final List<Phrase>? phrases;

  WordNotes({
    this.synonyms,
    this.relatedWords,
    this.englishDefinitions,
    this.phrases,
  });

  /// 从JSON字符串解析
  factory WordNotes.fromJsonString(String? jsonString) {
    if (jsonString == null || jsonString.isEmpty) {
      return WordNotes();
    }

    try {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return WordNotes.fromJson(json);
    } catch (e) {
      return WordNotes();
    }
  }

  /// 从JSON Map解析
  factory WordNotes.fromJson(Map<String, dynamic> json) {
    return WordNotes(
      synonyms: json['synonyms'] != null
          ? List<String>.from(json['synonyms'])
          : null,
      relatedWords: json['related_words'] != null
          ? (json['related_words'] as List)
              .map((e) => RelatedWord.fromJson(e))
              .toList()
          : null,
      englishDefinitions: json['english_definitions'] != null
          ? List<String>.from(json['english_definitions'])
          : null,
      phrases: json['phrases'] != null
          ? (json['phrases'] as List).map((e) => Phrase.fromJson(e)).toList()
          : null,
    );
  }

  /// 是否有内容
  bool get hasContent =>
      (synonyms != null && synonyms!.isNotEmpty) ||
      (relatedWords != null && relatedWords!.isNotEmpty) ||
      (englishDefinitions != null && englishDefinitions!.isNotEmpty) ||
      (phrases != null && phrases!.isNotEmpty);
}

/// 相关单词
class RelatedWord {
  final String word;
  final String? meaning;

  RelatedWord({
    required this.word,
    this.meaning,
  });

  factory RelatedWord.fromJson(Map<String, dynamic> json) {
    return RelatedWord(
      word: json['word'] ?? '',
      meaning: json['meaning']?.toString().trim(),
    );
  }
}

/// 短语
class Phrase {
  final String phrase;
  final String? meaning;

  Phrase({
    required this.phrase,
    this.meaning,
  });

  factory Phrase.fromJson(Map<String, dynamic> json) {
    return Phrase(
      phrase: json['phrase'] ?? '',
      meaning: json['meaning']?.toString().trim(),
    );
  }
}
