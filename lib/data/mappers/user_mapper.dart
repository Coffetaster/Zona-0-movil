import 'package:zona0_apk/data/models/user_model.dart';
import 'package:zona0_apk/domain/entities/user.dart';

class UserMapper {
  static User model_to_entity(UserModel model) => User(
      id: model.pk,
      username: model.username,
      name: model.name,
      last_name: model.last_name,
      image: model.image);

  static UserModel entity_to_model(User entity) => UserModel(
      pk: entity.id,
      username: entity.username,
      name: entity.name,
      last_name: entity.last_name,
      image: entity.image);
}
