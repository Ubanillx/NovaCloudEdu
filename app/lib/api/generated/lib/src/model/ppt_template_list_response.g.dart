// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ppt_template_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PptTemplateListResponse extends PptTemplateListResponse {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? coverUrl;
  @override
  final String? templateUrl;
  @override
  final int? slideCount;
  @override
  final bool? enabled;

  factory _$PptTemplateListResponse([
    void Function(PptTemplateListResponseBuilder)? updates,
  ]) => (PptTemplateListResponseBuilder()..update(updates))._build();

  _$PptTemplateListResponse._({
    this.id,
    this.name,
    this.description,
    this.coverUrl,
    this.templateUrl,
    this.slideCount,
    this.enabled,
  }) : super._();
  @override
  PptTemplateListResponse rebuild(
    void Function(PptTemplateListResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  PptTemplateListResponseBuilder toBuilder() =>
      PptTemplateListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PptTemplateListResponse &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        coverUrl == other.coverUrl &&
        templateUrl == other.templateUrl &&
        slideCount == other.slideCount &&
        enabled == other.enabled;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, coverUrl.hashCode);
    _$hash = $jc(_$hash, templateUrl.hashCode);
    _$hash = $jc(_$hash, slideCount.hashCode);
    _$hash = $jc(_$hash, enabled.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PptTemplateListResponse')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('coverUrl', coverUrl)
          ..add('templateUrl', templateUrl)
          ..add('slideCount', slideCount)
          ..add('enabled', enabled))
        .toString();
  }
}

class PptTemplateListResponseBuilder
    implements
        Builder<PptTemplateListResponse, PptTemplateListResponseBuilder> {
  _$PptTemplateListResponse? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _coverUrl;
  String? get coverUrl => _$this._coverUrl;
  set coverUrl(String? coverUrl) => _$this._coverUrl = coverUrl;

  String? _templateUrl;
  String? get templateUrl => _$this._templateUrl;
  set templateUrl(String? templateUrl) => _$this._templateUrl = templateUrl;

  int? _slideCount;
  int? get slideCount => _$this._slideCount;
  set slideCount(int? slideCount) => _$this._slideCount = slideCount;

  bool? _enabled;
  bool? get enabled => _$this._enabled;
  set enabled(bool? enabled) => _$this._enabled = enabled;

  PptTemplateListResponseBuilder() {
    PptTemplateListResponse._defaults(this);
  }

  PptTemplateListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _coverUrl = $v.coverUrl;
      _templateUrl = $v.templateUrl;
      _slideCount = $v.slideCount;
      _enabled = $v.enabled;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PptTemplateListResponse other) {
    _$v = other as _$PptTemplateListResponse;
  }

  @override
  void update(void Function(PptTemplateListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PptTemplateListResponse build() => _build();

  _$PptTemplateListResponse _build() {
    final _$result =
        _$v ??
        _$PptTemplateListResponse._(
          id: id,
          name: name,
          description: description,
          coverUrl: coverUrl,
          templateUrl: templateUrl,
          slideCount: slideCount,
          enabled: enabled,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
