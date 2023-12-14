import 'package:zona0_apk/data/models/company_model.dart';
import 'package:zona0_apk/domain/entities/company.dart';

class CompanyMapper {
  static Company model_to_entity(CompanyModel model) => Company(
      id: model.id,
      company_name: model.company_name,
      name: model.name,
      last_name: model.last_name,
      ci: model.ci,
      company_type: model.type,
      email: model.email,
      company_code: model.company_code,
      movil: model.movil,
      username: model.username,
      password: model.password);

  static CompanyModel entity_to_model(Company entity) => CompanyModel(
      id: entity.id,
      company_name: entity.company_name,
      name: entity.name,
      last_name: entity.last_name,
      ci: entity.ci,
      type: entity.company_type,
      email: entity.email,
      company_code: entity.company_code,
      movil: entity.movil,
      username: entity.username,
      password: entity.password);
}
