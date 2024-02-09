import 'package:zona0_apk/data/mappers/institution_gallery_mapper.dart';
import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

extension InstitutionMapper on Institution {
  InstitutionModel toModel() => InstitutionModel(
      id: id,
      institution_name: institution_name,
      institution_osp: institution_osp,
      description: description,
      image: image,
      galleryInstitution: galleryInstitution.map((e) => e.toModel()).toList());
}

extension InstitutionModelMapper on InstitutionModel {
  Institution toEntity() => Institution(
      id: id,
      institution_name: institution_name,
      institution_osp: institution_osp,
      description: description,
      image: image,
      galleryInstitution: galleryInstitution.map((e) => e.toEntity()).toList());
}
