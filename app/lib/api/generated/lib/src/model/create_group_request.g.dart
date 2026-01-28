// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_group_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateGroupRequest extends CreateGroupRequest {
  @override
  final String groupName;
  @override
  final String? description;
  @override
  final String? avatar;

  factory _$CreateGroupRequest([
    void Function(CreateGroupRequestBuilder)? updates,
  ]) => (CreateGroupRequestBuilder()..update(updates))._build();

  _$CreateGroupRequest._({
    required this.groupName,
    this.description,
    this.avatar,
  }) : super._();
  @override
  CreateGroupRequest rebuild(
    void Function(CreateGroupRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CreateGroupRequestBuilder toBuilder() =>
      CreateGroupRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateGroupRequest &&
        groupName == other.groupName &&
        description == other.description &&
        avatar == other.avatar;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, groupName.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, avatar.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateGroupRequest')
          ..add('groupName', groupName)
          ..add('description', description)
          ..add('avatar', avatar))
        .toString();
  }
}

class CreateGroupRequestBuilder
    implements Builder<CreateGroupRequest, CreateGroupRequestBuilder> {
  _$CreateGroupRequest? _$v;

  String? _groupName;
  String? get groupName => _$this._groupName;
  set groupName(String? groupName) => _$this._groupName = groupName;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _avatar;
  String? get avatar => _$this._avatar;
  set avatar(String? avatar) => _$this._avatar = avatar;

  CreateGroupRequestBuilder() {
    CreateGroupRequest._defaults(this);
  }

  CreateGroupRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _groupName = $v.groupName;
      _description = $v.description;
      _avatar = $v.avatar;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateGroupRequest other) {
    _$v = other as _$CreateGroupRequest;
  }

  @override
  void update(void Function(CreateGroupRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateGroupRequest build() => _build();

  _$CreateGroupRequest _build() {
    final _$result =
        _$v ??
        _$CreateGroupRequest._(
          groupName: BuiltValueNullFieldError.checkNotNull(
            groupName,
            r'CreateGroupRequest',
            'groupName',
          ),
          description: description,
          avatar: avatar,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
