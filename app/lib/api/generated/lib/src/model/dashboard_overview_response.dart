//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'dashboard_overview_response.g.dart';

/// DashboardOverviewResponse
///
/// Properties:
/// * [totalUsers]
/// * [usersByRole]
/// * [todayNewUsers]
/// * [yesterdayNewUsers]
/// * [totalCourses]
/// * [coursesByStatus]
/// * [activeMembers]
/// * [membersByPlan]
/// * [todayOrders]
/// * [yesterdayOrders]
/// * [todayRevenue]
/// * [yesterdayRevenue]
/// * [todayDau]
/// * [yesterdayDau]
/// * [pendingFeedbacks]
/// * [myClassCount]
/// * [myStudentCount]
@BuiltValue()
abstract class DashboardOverviewResponse
    implements
        Built<DashboardOverviewResponse, DashboardOverviewResponseBuilder> {
  @BuiltValueField(wireName: r'totalUsers')
  int? get totalUsers;

  @BuiltValueField(wireName: r'usersByRole')
  BuiltMap<String, int>? get usersByRole;

  @BuiltValueField(wireName: r'todayNewUsers')
  int? get todayNewUsers;

  @BuiltValueField(wireName: r'yesterdayNewUsers')
  int? get yesterdayNewUsers;

  @BuiltValueField(wireName: r'totalCourses')
  int? get totalCourses;

  @BuiltValueField(wireName: r'coursesByStatus')
  BuiltMap<String, int>? get coursesByStatus;

  @BuiltValueField(wireName: r'activeMembers')
  int? get activeMembers;

  @BuiltValueField(wireName: r'membersByPlan')
  BuiltMap<String, int>? get membersByPlan;

  @BuiltValueField(wireName: r'todayOrders')
  int? get todayOrders;

  @BuiltValueField(wireName: r'yesterdayOrders')
  int? get yesterdayOrders;

  @BuiltValueField(wireName: r'todayRevenue')
  double? get todayRevenue;

  @BuiltValueField(wireName: r'yesterdayRevenue')
  double? get yesterdayRevenue;

  @BuiltValueField(wireName: r'todayDau')
  int? get todayDau;

  @BuiltValueField(wireName: r'yesterdayDau')
  int? get yesterdayDau;

  @BuiltValueField(wireName: r'pendingFeedbacks')
  int? get pendingFeedbacks;

  @BuiltValueField(wireName: r'myClassCount')
  int? get myClassCount;

  @BuiltValueField(wireName: r'myStudentCount')
  int? get myStudentCount;

  DashboardOverviewResponse._();

  factory DashboardOverviewResponse(
          [void updates(DashboardOverviewResponseBuilder b)]) =
      _$DashboardOverviewResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DashboardOverviewResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DashboardOverviewResponse> get serializer =>
      _$DashboardOverviewResponseSerializer();
}

class _$DashboardOverviewResponseSerializer
    implements PrimitiveSerializer<DashboardOverviewResponse> {
  @override
  final Iterable<Type> types = const [
    DashboardOverviewResponse,
    _$DashboardOverviewResponse
  ];

  @override
  final String wireName = r'DashboardOverviewResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DashboardOverviewResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.totalUsers != null) {
      yield r'totalUsers';
      yield serializers.serialize(
        object.totalUsers,
        specifiedType: const FullType(int),
      );
    }
    if (object.usersByRole != null) {
      yield r'usersByRole';
      yield serializers.serialize(
        object.usersByRole,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(int)]),
      );
    }
    if (object.todayNewUsers != null) {
      yield r'todayNewUsers';
      yield serializers.serialize(
        object.todayNewUsers,
        specifiedType: const FullType(int),
      );
    }
    if (object.yesterdayNewUsers != null) {
      yield r'yesterdayNewUsers';
      yield serializers.serialize(
        object.yesterdayNewUsers,
        specifiedType: const FullType(int),
      );
    }
    if (object.totalCourses != null) {
      yield r'totalCourses';
      yield serializers.serialize(
        object.totalCourses,
        specifiedType: const FullType(int),
      );
    }
    if (object.coursesByStatus != null) {
      yield r'coursesByStatus';
      yield serializers.serialize(
        object.coursesByStatus,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(int)]),
      );
    }
    if (object.activeMembers != null) {
      yield r'activeMembers';
      yield serializers.serialize(
        object.activeMembers,
        specifiedType: const FullType(int),
      );
    }
    if (object.membersByPlan != null) {
      yield r'membersByPlan';
      yield serializers.serialize(
        object.membersByPlan,
        specifiedType:
            const FullType(BuiltMap, [FullType(String), FullType(int)]),
      );
    }
    if (object.todayOrders != null) {
      yield r'todayOrders';
      yield serializers.serialize(
        object.todayOrders,
        specifiedType: const FullType(int),
      );
    }
    if (object.yesterdayOrders != null) {
      yield r'yesterdayOrders';
      yield serializers.serialize(
        object.yesterdayOrders,
        specifiedType: const FullType(int),
      );
    }
    if (object.todayRevenue != null) {
      yield r'todayRevenue';
      yield serializers.serialize(
        object.todayRevenue,
        specifiedType: const FullType(double),
      );
    }
    if (object.yesterdayRevenue != null) {
      yield r'yesterdayRevenue';
      yield serializers.serialize(
        object.yesterdayRevenue,
        specifiedType: const FullType(double),
      );
    }
    if (object.todayDau != null) {
      yield r'todayDau';
      yield serializers.serialize(
        object.todayDau,
        specifiedType: const FullType(int),
      );
    }
    if (object.yesterdayDau != null) {
      yield r'yesterdayDau';
      yield serializers.serialize(
        object.yesterdayDau,
        specifiedType: const FullType(int),
      );
    }
    if (object.pendingFeedbacks != null) {
      yield r'pendingFeedbacks';
      yield serializers.serialize(
        object.pendingFeedbacks,
        specifiedType: const FullType(int),
      );
    }
    if (object.myClassCount != null) {
      yield r'myClassCount';
      yield serializers.serialize(
        object.myClassCount,
        specifiedType: const FullType(int),
      );
    }
    if (object.myStudentCount != null) {
      yield r'myStudentCount';
      yield serializers.serialize(
        object.myStudentCount,
        specifiedType: const FullType(int),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DashboardOverviewResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DashboardOverviewResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'totalUsers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalUsers = valueDes;
          break;
        case r'usersByRole':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltMap, [FullType(String), FullType(int)]),
          ) as BuiltMap<String, int>;
          result.usersByRole.replace(valueDes);
          break;
        case r'todayNewUsers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.todayNewUsers = valueDes;
          break;
        case r'yesterdayNewUsers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.yesterdayNewUsers = valueDes;
          break;
        case r'totalCourses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.totalCourses = valueDes;
          break;
        case r'coursesByStatus':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltMap, [FullType(String), FullType(int)]),
          ) as BuiltMap<String, int>;
          result.coursesByStatus.replace(valueDes);
          break;
        case r'activeMembers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.activeMembers = valueDes;
          break;
        case r'membersByPlan':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltMap, [FullType(String), FullType(int)]),
          ) as BuiltMap<String, int>;
          result.membersByPlan.replace(valueDes);
          break;
        case r'todayOrders':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.todayOrders = valueDes;
          break;
        case r'yesterdayOrders':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.yesterdayOrders = valueDes;
          break;
        case r'todayRevenue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.todayRevenue = valueDes;
          break;
        case r'yesterdayRevenue':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(double),
          ) as double;
          result.yesterdayRevenue = valueDes;
          break;
        case r'todayDau':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.todayDau = valueDes;
          break;
        case r'yesterdayDau':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.yesterdayDau = valueDes;
          break;
        case r'pendingFeedbacks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pendingFeedbacks = valueDes;
          break;
        case r'myClassCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.myClassCount = valueDes;
          break;
        case r'myStudentCount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.myStudentCount = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DashboardOverviewResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DashboardOverviewResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
