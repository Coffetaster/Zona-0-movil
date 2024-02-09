import 'package:zona0_apk/data/models/models.dart';
import 'package:zona0_apk/domain/entities/entities.dart';

extension InstitutionGalleryMapper on InstitutionGallery {
  InstitutionGalleryModel toModel() => InstitutionGalleryModel(
      id: id, institution: institution, image: image, description: description);
}

extension InstitutionGalleryModelMapper on InstitutionGalleryModel {
  InstitutionGallery toEntity() => InstitutionGallery(
      id: id, institution: institution, image: image, description: description);
}
