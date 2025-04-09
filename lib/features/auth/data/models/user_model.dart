import 'package:json_annotation/json_annotation.dart';
import 'package:primetag_task/features/auth/domain/entities/user.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? token;

  const UserModel({required this.token});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  User toEntity() => User(token: token);
}
