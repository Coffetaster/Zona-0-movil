import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

extension UserMapper on User {
  UserModel toModel() => UserModel(
      pk: id,
      username: username,
      name: name,
      last_name: lastName,
      image: image,
      zona_point: ospPoint,
      movil: movil,
      ci: ci,
      user_type: userType);
}

extension UserModelMapper on UserModel {
  User toEntity() => User(
      id: pk,
      username: username,
      name: name,
      lastName: last_name,
      image: image,
      ospPoint: zona_point,
      movil: movil,
      ci: ci,
      userType: user_type);
}
