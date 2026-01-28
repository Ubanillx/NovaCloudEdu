// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_teacher_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApplyTeacherRequest extends ApplyTeacherRequest {
  @override
  final String name;
  @override
  final BuiltList<String> expertise;
  @override
  final String? introduction;
  @override
  final String? certificateUrl;

  factory _$ApplyTeacherRequest([
    void Function(ApplyTeacherRequestBuilder)? updates,
  ]) => (ApplyTeacherRequestBuilder()..update(updates))._build();

  _$ApplyTeacherRequest._({
    required this.name,
    required this.expertise,
    this.introduction,
    this.certificateUrl,
  }) : super._();
  @override
  ApplyTeacherRequest rebuild(
    void Function(ApplyTeacherRequestBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  ApplyTeacherRequestBuilder toBuilder() =>
      ApplyTeacherRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApplyTeacherRequest &&
        name == other.name &&
        expertise == other.expertise &&
        introduction == other.introduction &&
        certificateUrl == other.certificateUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, expertise.hashCode);
    _$hash = $jc(_$hash, introduction.hashCode);
    _$hash = $jc(_$hash, certificateUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApplyTeacherRequest')
          ..add('name', name)
          ..add('expertise', expertise)
          ..add('introduction', introduction)
          ..add('certificateUrl', certificateUrl))
        .toString();
  }
}

class ApplyTeacherRequestBuilder
    implements Builder<ApplyTeacherRequest, ApplyTeacherRequestBuilder> {
  _$ApplyTeacherRequest? _$v;

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

  String? _certificateUrl;
  String? get certificateUrl => _$this._certificateUrl;
  set certificateUrl(String? certificateUrl) =>
      _$this._certificateUrl = certificateUrl;

  ApplyTeacherRequestBuilder() {
    ApplyTeacherRequest._defaults(this);
  }

  ApplyTeacherRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _expertise = $v.expertise.toBuilder();
      _introduction = $v.introduction;
      _certificateUrl = $v.certificateUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApplyTeacherRequest other) {
    _$v = other as _$ApplyTeacherRequest;
  }

  @override
  void update(void Function(ApplyTeacherRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApplyTeacherRequest build() => _build();

  _$ApplyTeacherRequest _build() {
    _$ApplyTeacherRequest _$result;
    try {
      _$result =
          _$v ??
          _$ApplyTeacherRequest._(
            name: BuiltValueNullFieldError.checkNotNull(
              name,
              r'ApplyTeacherRequest',
              'name',
            ),
            expertise: expertise.build(),
            introduction: introduction,
            certificateUrl: certificateUrl,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'expertise';
        expertise.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'ApplyTeacherRequest',
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
