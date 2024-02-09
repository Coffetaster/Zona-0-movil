class InstitutionGallery {
  int id;
  String institution;
  String image;
  String description;
  InstitutionGallery({
    required this.id,
    required this.institution,
    required this.image,
    required this.description,
  });

  @override
  String toString() {
    return 'InstitutionGallery(id: $id, institution: $institution, image: $image, description: $description)';
  }
}
