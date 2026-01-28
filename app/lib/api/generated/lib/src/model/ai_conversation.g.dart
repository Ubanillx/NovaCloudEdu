// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_conversation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AiConversationConversationTypeEnum
_$aiConversationConversationTypeEnum_SUMMARY =
    const AiConversationConversationTypeEnum._('SUMMARY');
const AiConversationConversationTypeEnum
_$aiConversationConversationTypeEnum_QA =
    const AiConversationConversationTypeEnum._('QA');
const AiConversationConversationTypeEnum
_$aiConversationConversationTypeEnum_KNOWLEDGE =
    const AiConversationConversationTypeEnum._('KNOWLEDGE');
const AiConversationConversationTypeEnum
_$aiConversationConversationTypeEnum_QUIZ =
    const AiConversationConversationTypeEnum._('QUIZ');

AiConversationConversationTypeEnum _$aiConversationConversationTypeEnumValueOf(
  String name,
) {
  switch (name) {
    case 'SUMMARY':
      return _$aiConversationConversationTypeEnum_SUMMARY;
    case 'QA':
      return _$aiConversationConversationTypeEnum_QA;
    case 'KNOWLEDGE':
      return _$aiConversationConversationTypeEnum_KNOWLEDGE;
    case 'QUIZ':
      return _$aiConversationConversationTypeEnum_QUIZ;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AiConversationConversationTypeEnum>
_$aiConversationConversationTypeEnumValues =
    BuiltSet<AiConversationConversationTypeEnum>(
      const <AiConversationConversationTypeEnum>[
        _$aiConversationConversationTypeEnum_SUMMARY,
        _$aiConversationConversationTypeEnum_QA,
        _$aiConversationConversationTypeEnum_KNOWLEDGE,
        _$aiConversationConversationTypeEnum_QUIZ,
      ],
    );

Serializer<AiConversationConversationTypeEnum>
_$aiConversationConversationTypeEnumSerializer =
    _$AiConversationConversationTypeEnumSerializer();

class _$AiConversationConversationTypeEnumSerializer
    implements PrimitiveSerializer<AiConversationConversationTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'SUMMARY': 'SUMMARY',
    'QA': 'QA',
    'KNOWLEDGE': 'KNOWLEDGE',
    'QUIZ': 'QUIZ',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SUMMARY': 'SUMMARY',
    'QA': 'QA',
    'KNOWLEDGE': 'KNOWLEDGE',
    'QUIZ': 'QUIZ',
  };

  @override
  final Iterable<Type> types = const <Type>[AiConversationConversationTypeEnum];
  @override
  final String wireName = 'AiConversationConversationTypeEnum';

  @override
  Object serialize(
    Serializers serializers,
    AiConversationConversationTypeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  AiConversationConversationTypeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => AiConversationConversationTypeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$AiConversation extends AiConversation {
  @override
  final AiConversationId? id;
  @override
  final UserId? userId;
  @override
  final BookId? bookId;
  @override
  final ChapterId? chapterId;
  @override
  final AiConversationConversationTypeEnum? conversationType;
  @override
  final BuiltList<ConversationMessage>? messages;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;
  @override
  final int? messageCount;

  factory _$AiConversation([void Function(AiConversationBuilder)? updates]) =>
      (AiConversationBuilder()..update(updates))._build();

  _$AiConversation._({
    this.id,
    this.userId,
    this.bookId,
    this.chapterId,
    this.conversationType,
    this.messages,
    this.createTime,
    this.updateTime,
    this.messageCount,
  }) : super._();
  @override
  AiConversation rebuild(void Function(AiConversationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AiConversationBuilder toBuilder() => AiConversationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AiConversation &&
        id == other.id &&
        userId == other.userId &&
        bookId == other.bookId &&
        chapterId == other.chapterId &&
        conversationType == other.conversationType &&
        messages == other.messages &&
        createTime == other.createTime &&
        updateTime == other.updateTime &&
        messageCount == other.messageCount;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, bookId.hashCode);
    _$hash = $jc(_$hash, chapterId.hashCode);
    _$hash = $jc(_$hash, conversationType.hashCode);
    _$hash = $jc(_$hash, messages.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jc(_$hash, messageCount.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AiConversation')
          ..add('id', id)
          ..add('userId', userId)
          ..add('bookId', bookId)
          ..add('chapterId', chapterId)
          ..add('conversationType', conversationType)
          ..add('messages', messages)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime)
          ..add('messageCount', messageCount))
        .toString();
  }
}

class AiConversationBuilder
    implements Builder<AiConversation, AiConversationBuilder> {
  _$AiConversation? _$v;

  AiConversationIdBuilder? _id;
  AiConversationIdBuilder get id => _$this._id ??= AiConversationIdBuilder();
  set id(AiConversationIdBuilder? id) => _$this._id = id;

  UserIdBuilder? _userId;
  UserIdBuilder get userId => _$this._userId ??= UserIdBuilder();
  set userId(UserIdBuilder? userId) => _$this._userId = userId;

  BookIdBuilder? _bookId;
  BookIdBuilder get bookId => _$this._bookId ??= BookIdBuilder();
  set bookId(BookIdBuilder? bookId) => _$this._bookId = bookId;

  ChapterIdBuilder? _chapterId;
  ChapterIdBuilder get chapterId => _$this._chapterId ??= ChapterIdBuilder();
  set chapterId(ChapterIdBuilder? chapterId) => _$this._chapterId = chapterId;

  AiConversationConversationTypeEnum? _conversationType;
  AiConversationConversationTypeEnum? get conversationType =>
      _$this._conversationType;
  set conversationType(AiConversationConversationTypeEnum? conversationType) =>
      _$this._conversationType = conversationType;

  ListBuilder<ConversationMessage>? _messages;
  ListBuilder<ConversationMessage> get messages =>
      _$this._messages ??= ListBuilder<ConversationMessage>();
  set messages(ListBuilder<ConversationMessage>? messages) =>
      _$this._messages = messages;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  int? _messageCount;
  int? get messageCount => _$this._messageCount;
  set messageCount(int? messageCount) => _$this._messageCount = messageCount;

  AiConversationBuilder() {
    AiConversation._defaults(this);
  }

  AiConversationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id?.toBuilder();
      _userId = $v.userId?.toBuilder();
      _bookId = $v.bookId?.toBuilder();
      _chapterId = $v.chapterId?.toBuilder();
      _conversationType = $v.conversationType;
      _messages = $v.messages?.toBuilder();
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _messageCount = $v.messageCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AiConversation other) {
    _$v = other as _$AiConversation;
  }

  @override
  void update(void Function(AiConversationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AiConversation build() => _build();

  _$AiConversation _build() {
    _$AiConversation _$result;
    try {
      _$result =
          _$v ??
          _$AiConversation._(
            id: _id?.build(),
            userId: _userId?.build(),
            bookId: _bookId?.build(),
            chapterId: _chapterId?.build(),
            conversationType: conversationType,
            messages: _messages?.build(),
            createTime: createTime,
            updateTime: updateTime,
            messageCount: messageCount,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'id';
        _id?.build();
        _$failedField = 'userId';
        _userId?.build();
        _$failedField = 'bookId';
        _bookId?.build();
        _$failedField = 'chapterId';
        _chapterId?.build();

        _$failedField = 'messages';
        _messages?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'AiConversation',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
