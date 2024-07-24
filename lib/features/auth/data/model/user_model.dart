import 'package:house_chores/core/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(id: map['id'], email: map['email']);
  }

  UserModel copyWith({
    String? id,
    String? email,
  }) {
    return UserModel(id: id ?? this.id, email: email ?? this.email);
  }
}
