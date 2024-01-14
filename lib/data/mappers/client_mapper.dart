import 'package:zona0_apk/data/models/client_model.dart';
import 'package:zona0_apk/domain/entities/client.dart';

extension ClientMapper on Client {
  ClientModel toModel() => ClientModel(
      id: id,
      username: username,
      password: password,
      name: name,
      last_name: last_name,
      email: email,
      movil: movil,
      ci: ci);
}

extension ClientModelMapper on ClientModel {
  Client toEntity() => Client(
      id: id,
      username: username,
      password: password,
      name: name,
      last_name: last_name,
      email: email,
      movil: movil,
      ci: ci);
}
