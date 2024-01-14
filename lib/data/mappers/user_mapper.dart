import 'package:zona0_apk/data/models/user_model.dart';
import 'package:zona0_apk/domain/entities/user.dart';

extension UserMapper on User {
  UserModel toModel() => UserModel(
      pk: id,
      username: username,
      name: name,
      last_name: last_name,
      image: image);
}

extension UserModelMapper on UserModel {
  User toEntity() => User(
      id: pk,
      username: username,
      name: name,
      last_name: last_name,
      image: image);
}
