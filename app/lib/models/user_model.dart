/// 用户模型示例
/// 数据模型定义
library;

class UserModel {
  final String id;
  final String name;
  final String? email;
  final String? avatar;

  UserModel({
    required this.id,
    required this.name,
    this.email,
    this.avatar,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
    };
  }
}
