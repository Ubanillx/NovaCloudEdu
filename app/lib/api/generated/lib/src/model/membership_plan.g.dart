// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MembershipPlanCodeEnum _$membershipPlanCodeEnum_FREE =
    const MembershipPlanCodeEnum._('FREE');
const MembershipPlanCodeEnum _$membershipPlanCodeEnum_BASIC =
    const MembershipPlanCodeEnum._('BASIC');
const MembershipPlanCodeEnum _$membershipPlanCodeEnum_PRO =
    const MembershipPlanCodeEnum._('PRO');
const MembershipPlanCodeEnum _$membershipPlanCodeEnum_TEACHER =
    const MembershipPlanCodeEnum._('TEACHER');

MembershipPlanCodeEnum _$membershipPlanCodeEnumValueOf(String name) {
  switch (name) {
    case 'FREE':
      return _$membershipPlanCodeEnum_FREE;
    case 'BASIC':
      return _$membershipPlanCodeEnum_BASIC;
    case 'PRO':
      return _$membershipPlanCodeEnum_PRO;
    case 'TEACHER':
      return _$membershipPlanCodeEnum_TEACHER;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MembershipPlanCodeEnum> _$membershipPlanCodeEnumValues =
    BuiltSet<MembershipPlanCodeEnum>(const <MembershipPlanCodeEnum>[
      _$membershipPlanCodeEnum_FREE,
      _$membershipPlanCodeEnum_BASIC,
      _$membershipPlanCodeEnum_PRO,
      _$membershipPlanCodeEnum_TEACHER,
    ]);

Serializer<MembershipPlanCodeEnum> _$membershipPlanCodeEnumSerializer =
    _$MembershipPlanCodeEnumSerializer();

class _$MembershipPlanCodeEnumSerializer
    implements PrimitiveSerializer<MembershipPlanCodeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'FREE': 'FREE',
    'BASIC': 'BASIC',
    'PRO': 'PRO',
    'TEACHER': 'TEACHER',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'FREE': 'FREE',
    'BASIC': 'BASIC',
    'PRO': 'PRO',
    'TEACHER': 'TEACHER',
  };

  @override
  final Iterable<Type> types = const <Type>[MembershipPlanCodeEnum];
  @override
  final String wireName = 'MembershipPlanCodeEnum';

  @override
  Object serialize(
    Serializers serializers,
    MembershipPlanCodeEnum object, {
    FullType specifiedType = FullType.unspecified,
  }) => _toWire[object.name] ?? object.name;

  @override
  MembershipPlanCodeEnum deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) => MembershipPlanCodeEnum.valueOf(
    _fromWire[serialized] ?? (serialized is String ? serialized : ''),
  );
}

class _$MembershipPlan extends MembershipPlan {
  @override
  final int? id;
  @override
  final String? name;
  @override
  final MembershipPlanCodeEnum? code;
  @override
  final String? description;
  @override
  final num? price;
  @override
  final int? durationDays;
  @override
  final int? aiChatDailyLimit;
  @override
  final int? aiChatMonthlyLimit;
  @override
  final int? aiPptDailyLimit;
  @override
  final int? aiPptMonthlyLimit;
  @override
  final int? aiExamDailyLimit;
  @override
  final int? aiExamMonthlyLimit;
  @override
  final int? aiBookDailyLimit;
  @override
  final int? aiBookMonthlyLimit;
  @override
  final int? aiGradingDailyLimit;
  @override
  final int? aiGradingMonthlyLimit;
  @override
  final bool? courseMemberAccess;
  @override
  final int? sortOrder;
  @override
  final DateTime? createTime;
  @override
  final DateTime? updateTime;
  @override
  final bool? delete;
  @override
  final bool? default_;

  factory _$MembershipPlan([void Function(MembershipPlanBuilder)? updates]) =>
      (MembershipPlanBuilder()..update(updates))._build();

  _$MembershipPlan._({
    this.id,
    this.name,
    this.code,
    this.description,
    this.price,
    this.durationDays,
    this.aiChatDailyLimit,
    this.aiChatMonthlyLimit,
    this.aiPptDailyLimit,
    this.aiPptMonthlyLimit,
    this.aiExamDailyLimit,
    this.aiExamMonthlyLimit,
    this.aiBookDailyLimit,
    this.aiBookMonthlyLimit,
    this.aiGradingDailyLimit,
    this.aiGradingMonthlyLimit,
    this.courseMemberAccess,
    this.sortOrder,
    this.createTime,
    this.updateTime,
    this.delete,
    this.default_,
  }) : super._();
  @override
  MembershipPlan rebuild(void Function(MembershipPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MembershipPlanBuilder toBuilder() => MembershipPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MembershipPlan &&
        id == other.id &&
        name == other.name &&
        code == other.code &&
        description == other.description &&
        price == other.price &&
        durationDays == other.durationDays &&
        aiChatDailyLimit == other.aiChatDailyLimit &&
        aiChatMonthlyLimit == other.aiChatMonthlyLimit &&
        aiPptDailyLimit == other.aiPptDailyLimit &&
        aiPptMonthlyLimit == other.aiPptMonthlyLimit &&
        aiExamDailyLimit == other.aiExamDailyLimit &&
        aiExamMonthlyLimit == other.aiExamMonthlyLimit &&
        aiBookDailyLimit == other.aiBookDailyLimit &&
        aiBookMonthlyLimit == other.aiBookMonthlyLimit &&
        aiGradingDailyLimit == other.aiGradingDailyLimit &&
        aiGradingMonthlyLimit == other.aiGradingMonthlyLimit &&
        courseMemberAccess == other.courseMemberAccess &&
        sortOrder == other.sortOrder &&
        createTime == other.createTime &&
        updateTime == other.updateTime &&
        delete == other.delete &&
        default_ == other.default_;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jc(_$hash, durationDays.hashCode);
    _$hash = $jc(_$hash, aiChatDailyLimit.hashCode);
    _$hash = $jc(_$hash, aiChatMonthlyLimit.hashCode);
    _$hash = $jc(_$hash, aiPptDailyLimit.hashCode);
    _$hash = $jc(_$hash, aiPptMonthlyLimit.hashCode);
    _$hash = $jc(_$hash, aiExamDailyLimit.hashCode);
    _$hash = $jc(_$hash, aiExamMonthlyLimit.hashCode);
    _$hash = $jc(_$hash, aiBookDailyLimit.hashCode);
    _$hash = $jc(_$hash, aiBookMonthlyLimit.hashCode);
    _$hash = $jc(_$hash, aiGradingDailyLimit.hashCode);
    _$hash = $jc(_$hash, aiGradingMonthlyLimit.hashCode);
    _$hash = $jc(_$hash, courseMemberAccess.hashCode);
    _$hash = $jc(_$hash, sortOrder.hashCode);
    _$hash = $jc(_$hash, createTime.hashCode);
    _$hash = $jc(_$hash, updateTime.hashCode);
    _$hash = $jc(_$hash, delete.hashCode);
    _$hash = $jc(_$hash, default_.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MembershipPlan')
          ..add('id', id)
          ..add('name', name)
          ..add('code', code)
          ..add('description', description)
          ..add('price', price)
          ..add('durationDays', durationDays)
          ..add('aiChatDailyLimit', aiChatDailyLimit)
          ..add('aiChatMonthlyLimit', aiChatMonthlyLimit)
          ..add('aiPptDailyLimit', aiPptDailyLimit)
          ..add('aiPptMonthlyLimit', aiPptMonthlyLimit)
          ..add('aiExamDailyLimit', aiExamDailyLimit)
          ..add('aiExamMonthlyLimit', aiExamMonthlyLimit)
          ..add('aiBookDailyLimit', aiBookDailyLimit)
          ..add('aiBookMonthlyLimit', aiBookMonthlyLimit)
          ..add('aiGradingDailyLimit', aiGradingDailyLimit)
          ..add('aiGradingMonthlyLimit', aiGradingMonthlyLimit)
          ..add('courseMemberAccess', courseMemberAccess)
          ..add('sortOrder', sortOrder)
          ..add('createTime', createTime)
          ..add('updateTime', updateTime)
          ..add('delete', delete)
          ..add('default_', default_))
        .toString();
  }
}

class MembershipPlanBuilder
    implements Builder<MembershipPlan, MembershipPlanBuilder> {
  _$MembershipPlan? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  MembershipPlanCodeEnum? _code;
  MembershipPlanCodeEnum? get code => _$this._code;
  set code(MembershipPlanCodeEnum? code) => _$this._code = code;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  num? _price;
  num? get price => _$this._price;
  set price(num? price) => _$this._price = price;

  int? _durationDays;
  int? get durationDays => _$this._durationDays;
  set durationDays(int? durationDays) => _$this._durationDays = durationDays;

  int? _aiChatDailyLimit;
  int? get aiChatDailyLimit => _$this._aiChatDailyLimit;
  set aiChatDailyLimit(int? aiChatDailyLimit) =>
      _$this._aiChatDailyLimit = aiChatDailyLimit;

  int? _aiChatMonthlyLimit;
  int? get aiChatMonthlyLimit => _$this._aiChatMonthlyLimit;
  set aiChatMonthlyLimit(int? aiChatMonthlyLimit) =>
      _$this._aiChatMonthlyLimit = aiChatMonthlyLimit;

  int? _aiPptDailyLimit;
  int? get aiPptDailyLimit => _$this._aiPptDailyLimit;
  set aiPptDailyLimit(int? aiPptDailyLimit) =>
      _$this._aiPptDailyLimit = aiPptDailyLimit;

  int? _aiPptMonthlyLimit;
  int? get aiPptMonthlyLimit => _$this._aiPptMonthlyLimit;
  set aiPptMonthlyLimit(int? aiPptMonthlyLimit) =>
      _$this._aiPptMonthlyLimit = aiPptMonthlyLimit;

  int? _aiExamDailyLimit;
  int? get aiExamDailyLimit => _$this._aiExamDailyLimit;
  set aiExamDailyLimit(int? aiExamDailyLimit) =>
      _$this._aiExamDailyLimit = aiExamDailyLimit;

  int? _aiExamMonthlyLimit;
  int? get aiExamMonthlyLimit => _$this._aiExamMonthlyLimit;
  set aiExamMonthlyLimit(int? aiExamMonthlyLimit) =>
      _$this._aiExamMonthlyLimit = aiExamMonthlyLimit;

  int? _aiBookDailyLimit;
  int? get aiBookDailyLimit => _$this._aiBookDailyLimit;
  set aiBookDailyLimit(int? aiBookDailyLimit) =>
      _$this._aiBookDailyLimit = aiBookDailyLimit;

  int? _aiBookMonthlyLimit;
  int? get aiBookMonthlyLimit => _$this._aiBookMonthlyLimit;
  set aiBookMonthlyLimit(int? aiBookMonthlyLimit) =>
      _$this._aiBookMonthlyLimit = aiBookMonthlyLimit;

  int? _aiGradingDailyLimit;
  int? get aiGradingDailyLimit => _$this._aiGradingDailyLimit;
  set aiGradingDailyLimit(int? aiGradingDailyLimit) =>
      _$this._aiGradingDailyLimit = aiGradingDailyLimit;

  int? _aiGradingMonthlyLimit;
  int? get aiGradingMonthlyLimit => _$this._aiGradingMonthlyLimit;
  set aiGradingMonthlyLimit(int? aiGradingMonthlyLimit) =>
      _$this._aiGradingMonthlyLimit = aiGradingMonthlyLimit;

  bool? _courseMemberAccess;
  bool? get courseMemberAccess => _$this._courseMemberAccess;
  set courseMemberAccess(bool? courseMemberAccess) =>
      _$this._courseMemberAccess = courseMemberAccess;

  int? _sortOrder;
  int? get sortOrder => _$this._sortOrder;
  set sortOrder(int? sortOrder) => _$this._sortOrder = sortOrder;

  DateTime? _createTime;
  DateTime? get createTime => _$this._createTime;
  set createTime(DateTime? createTime) => _$this._createTime = createTime;

  DateTime? _updateTime;
  DateTime? get updateTime => _$this._updateTime;
  set updateTime(DateTime? updateTime) => _$this._updateTime = updateTime;

  bool? _delete;
  bool? get delete => _$this._delete;
  set delete(bool? delete) => _$this._delete = delete;

  bool? _default_;
  bool? get default_ => _$this._default_;
  set default_(bool? default_) => _$this._default_ = default_;

  MembershipPlanBuilder() {
    MembershipPlan._defaults(this);
  }

  MembershipPlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _code = $v.code;
      _description = $v.description;
      _price = $v.price;
      _durationDays = $v.durationDays;
      _aiChatDailyLimit = $v.aiChatDailyLimit;
      _aiChatMonthlyLimit = $v.aiChatMonthlyLimit;
      _aiPptDailyLimit = $v.aiPptDailyLimit;
      _aiPptMonthlyLimit = $v.aiPptMonthlyLimit;
      _aiExamDailyLimit = $v.aiExamDailyLimit;
      _aiExamMonthlyLimit = $v.aiExamMonthlyLimit;
      _aiBookDailyLimit = $v.aiBookDailyLimit;
      _aiBookMonthlyLimit = $v.aiBookMonthlyLimit;
      _aiGradingDailyLimit = $v.aiGradingDailyLimit;
      _aiGradingMonthlyLimit = $v.aiGradingMonthlyLimit;
      _courseMemberAccess = $v.courseMemberAccess;
      _sortOrder = $v.sortOrder;
      _createTime = $v.createTime;
      _updateTime = $v.updateTime;
      _delete = $v.delete;
      _default_ = $v.default_;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MembershipPlan other) {
    _$v = other as _$MembershipPlan;
  }

  @override
  void update(void Function(MembershipPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MembershipPlan build() => _build();

  _$MembershipPlan _build() {
    final _$result =
        _$v ??
        _$MembershipPlan._(
          id: id,
          name: name,
          code: code,
          description: description,
          price: price,
          durationDays: durationDays,
          aiChatDailyLimit: aiChatDailyLimit,
          aiChatMonthlyLimit: aiChatMonthlyLimit,
          aiPptDailyLimit: aiPptDailyLimit,
          aiPptMonthlyLimit: aiPptMonthlyLimit,
          aiExamDailyLimit: aiExamDailyLimit,
          aiExamMonthlyLimit: aiExamMonthlyLimit,
          aiBookDailyLimit: aiBookDailyLimit,
          aiBookMonthlyLimit: aiBookMonthlyLimit,
          aiGradingDailyLimit: aiGradingDailyLimit,
          aiGradingMonthlyLimit: aiGradingMonthlyLimit,
          courseMemberAccess: courseMemberAccess,
          sortOrder: sortOrder,
          createTime: createTime,
          updateTime: updateTime,
          delete: delete,
          default_: default_,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
