// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_teacher_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateTeacherRequest extends UpdateTeacherRequest {
  @override
  final String name;
  @override
  final BuiltList<String> expertise;
  @override
  final String? introduction;

  factory _$UpdateTeacherRequest([
    void Function(UpdateTeacherRequestBuilder)? updates,
  ]) => (UpdateTeacherRequestBuilder()..update(updates))._build();

  _$UpdateTeacherRequest._({
    required this.name,
    required this.expertise,
    this.introduction,
  }) : super._();
  @override
  UpdateTeacherRequest rebuild(
    void Function(UpdateTeacherRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  UpdateTeacherRequestBuilder toBuilder() =>
      UpdateTeacherRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateTeacherRequest &&
        name == other.name &&
        expertise == other.expertise &&
        introduction == other.introduction;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, expertise.hashCode);
    _$hash = $jc(_$hash, introduction.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateTeacherRequest')
          ..add('name', name)
          ..add('expertise', expertise)
          ..add('introduction', introduction))
        .toString();
  }
}

class UpdateTeacherRequestBuilder
    implements Builder<UpdateTeacherRequest, UpdateTeacherRequestBuilder> {
  _$UpdateTeacherRequest? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  ListBuilder<String>? _expertise;
  ListBuilder<String> get expertise =>
      _$this._expertise ??= ListBuilder<String>();
  set expertise(ListBuilder<String>? expertise) =>
      _$this._expertise = expertise;

  String? _introduction;
  String? get introduction => _$this._introduction;
  set introduction(String? introduction) => _$this._introduction = introduction;

  UpdateTeacherRequestBuilder() {
    UpdateTeacherRequest._defaults(this);
  }

  UpdateTeacherRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _expertise = $v.expertise.toBuilder();
      _introduction = $v.introduction;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateTeacherRequest other) {
    _$v = other as _$UpdateTeacherRequest;
  }

  @override
  void update(void Function(UpdateTeacherRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateTeacherRequest build() => _build();

  _$UpdateTeacherRequest _build() {
    _$UpdateTeacherRequest _$result;
    try {
      _$result =
          _$v ??
          _$UpdateTeacherRequest._(
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'UpdateTeacherRequest',
              'name',
            ),
            expertise: expertise.build(),
            introduction: introduction,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'expertise';
        expertise.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'UpdateTeacherRequest',
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
