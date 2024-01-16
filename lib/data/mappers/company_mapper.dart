import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

extension CompanyMapper on Company {
  CompanyModel toModel() => CompanyModel(
      id: id,
      company_name: company_name,
      name: name,
      last_name: last_name,
      ci: ci,
      type: company_type,
      email: email,
      company_code: company_code,
      movil: movil,
      username: username,
      password: password);
}

extension CompanyModelMapper on CompanyModel {
  Company toEntity() => Company(
      id: id,
      company_name: company_name,
      name: name,
      last_name: last_name,
      ci: ci,
      company_type: type,
      email: email,
      company_code: company_code,
      movil: movil,
      username: username,
      password: password);
}
