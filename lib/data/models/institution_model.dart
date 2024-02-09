import 'dart:convert';

import 'institution_gallery_model.dart';

class InstitutionModel {
  int id;
  String institution_name;
  double institution_osp;
  String description;
  String image;
  List<InstitutionGalleryModel> galleryInstitution;
  InstitutionModel({
    required this.id,
    required this.institution_name,
    required this.institution_osp,
    required this.description,
    required this.image,
    required this.galleryInstitution,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'institution_name': institution_name,
      'institution_osp': institution_osp,
      'description': description,
      'image': image,
      'galleryInstitution': galleryInstitution.map((x) => x.toMap()).toList(),
    };
  }

  factory InstitutionModel.fromMap(Map<String, dynamic> map) {
    return InstitutionModel(
      id: map['id'] ?? 0,
      institution_name: map['institution_name'] ?? '',
      institution_osp: double.tryParse(map['institution_osp'] ?? "0.0") ?? 0.0,
      description: map['description'] ?? '',
      image: map['image'] ?? '',
      galleryInstitution: List<InstitutionGalleryModel>.from(map['galleryInstitution']?.map((x) => InstitutionGalleryModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory InstitutionModel.fromJson(String source) => InstitutionModel.fromMap(json.decode(source));
}
