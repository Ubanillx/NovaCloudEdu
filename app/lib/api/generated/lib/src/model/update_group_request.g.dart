// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_group_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateGroupRequest extends UpdateGroupRequest {
  @override
  final String? groupName;
  @override
  final String? description;
  @override
  final String? avatar;

  factory _$UpdateGroupRequest([
    void Function(UpdateGroupRequestBuilder)? updates,
  ]) => (UpdateGroupRequestBuilder()..update(updates))._build();

  _$UpdateGroupRequest._({this.groupName, this.description, this.avatar})
    : super._();
  @override
  UpdateGroupRequest rebuild(
    void Function(UpdateGroupRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateGroupRequestBuilder toBuilder() =>
      UpdateGroupRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateGroupRequest &&
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
    return (newBuiltValueToStringHelper(r'UpdateGroupRequest')
          ..add('groupName', groupName)
          ..add('description', description)
          ..add('avatar', avatar))
        .toString();
  }
}

class UpdateGroupRequestBuilder
    implements Builder<UpdateGroupRequest, UpdateGroupRequestBuilder> {
  _$UpdateGroupRequest? _$v;

  String? _groupName;
  String? get groupName => _$this._groupName;
  set groupName(String? groupName) => _$this._groupName = groupName;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _avatar;
  String? get avatar => _$this._avatar;
  set avatar(String? avatar) => _$this._avatar = avatar;

  UpdateGroupRequestBuilder() {
    UpdateGroupRequest._defaults(this);
  }

  UpdateGroupRequestBuilder get _$this {
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
  void replace(UpdateGroupRequest other) {
    _$v = other as _$UpdateGroupRequest;
  }

  @override
  void update(void Function(UpdateGroupRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateGroupRequest build() => _build();

  _$UpdateGroupRequest _build() {
    final _$result =
        _$v ??
        _$UpdateGroupRequest._(
          groupName: groupName,
          description: description,
          avatar: avatar,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
