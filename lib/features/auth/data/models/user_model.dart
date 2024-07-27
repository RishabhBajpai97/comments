

import 'package:comments/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.uuid, required super.email, required super.name});
  factory UserModel.fromJSON(Map<String, dynamic> map) {
    return UserModel(
        uuid: map["id"] ?? "",
        email: map["email"] ?? "",
        name: map["name"] ?? "");
  }
  @override
  String toString() {
    return "Id:$uuid, Name:$name, Email:$email";
  }

  UserModel copyWith({String? uuid, String? name, String? email}) {
    return UserModel(
      uuid: uuid??this.uuid,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }
}
