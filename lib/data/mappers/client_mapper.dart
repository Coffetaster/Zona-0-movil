import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

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
