import 'package:house_chores/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(id: map['id'], email: map['email']);
  }
}
