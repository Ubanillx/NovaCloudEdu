// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ClassResponse extends ClassResponse {
  @override
  final String? id;
  @override
  final String? className;
  @override
  final String? description;
  @override
  final String? creatorId;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;

  factory _$ClassResponse([void Function(ClassResponseBuilder)? updates]) =>
      (ClassResponseBuilder()..update(updates))._build();

  _$ClassResponse._({
    this.id,
    this.className,
    this.description,
    this.creatorId,
    this.createTime,
    this.updateTime,
  }) : super._();
  @override
  ClassResponse rebuild(void Function(ClassResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClassResponseBuilder toBuilder() => ClassResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ClassResponse &&
        id == other.id &&
        className == other.className &&
        description == other.description &&
        creatorId == other.creatorId &&
        createTime == other.createTime &&
        updateTime == other.updateTime;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, className.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, creatorId.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ClassResponse')
          ..add('id', id)
          ..add('className', className)
          ..add('description', description)
          ..add('creatorId', creatorId)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime))
        .toString();
  }
}

class ClassResponseBuilder
    implements Builder<ClassResponse, ClassResponseBuilder> {
  _$ClassResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _className;
  String? get className => _$this._className;
  set className(String? className) => _$this._className = className;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _creatorId;
  String? get creatorId => _$this._creatorId;
  set creatorId(String? creatorId) => _$this._creatorId = creatorId;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  ClassResponseBuilder() {
    ClassResponse._defaults(this);
  }

  ClassResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _className = $v.className;
      _description = $v.description;
      _creatorId = $v.creatorId;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ClassResponse other) {
    _$v = other as _$ClassResponse;
  }

  @override
  void update(void Function(ClassResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ClassResponse build() => _build();

  _$ClassResponse _build() {
    final _$result =
        _$v ??
        _$ClassResponse._(
          id: id,
          className: className,
          description: description,
          creatorId: creatorId,
          createTime: createTime,
          updateTime: updateTime,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
