import 'package:zona0_apk/data/models/client_model.dart';
import 'package:zona0_apk/domain/entities/client.dart';

class ClientMapper {
  static Client model_to_entity(ClientModel model) => Client(
      id: model.id,
      username: model.username,
      password: model.password,
      name: model.name,
      last_name: model.last_name,
      email: model.email,
      movil: model.movil,
      ci: model.ci);

  static ClientModel entity_to_model(Client entity) => ClientModel(
      id: entity.id,
      username: entity.username,
      password: entity.password,
      name: entity.name,
      last_name: entity.last_name,
      email: entity.email,
      movil: entity.movil,
      ci: entity.ci);
}
