import 'dart:convert';

class InstitutionGalleryModel {
  int id;
  String institution;
  String image;
  String description;
  InstitutionGalleryModel({
    required this.id,
    required this.institution,
    required this.image,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'institution': institution,
      'image': image,
      'description': description,
    };
  }

  factory InstitutionGalleryModel.fromMap(Map<String, dynamic> map) {
    return InstitutionGalleryModel(
      id: map['id'] ?? 0,
      institution: map['institution'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory InstitutionGalleryModel.fromJson(String source) => InstitutionGalleryModel.fromMap(json.decode(source));
}
