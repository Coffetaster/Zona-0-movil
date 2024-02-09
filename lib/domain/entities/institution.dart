import 'institution_gallery.dart';

class Institution {
  int id;
  String institution_name;
  double institution_osp;
  String description;
  String image;
  List<InstitutionGallery> galleryInstitution;
  Institution({
    required this.id,
    required this.institution_name,
    required this.institution_osp,
    required this.description,
    required this.image,
    required this.galleryInstitution,
  });

  @override
  String toString() {
    return 'Institution(id: $id, institution_name: $institution_name, institution_osp: $institution_osp, description: $description, image: $image, galleryInstitution: $galleryInstitution)';
  }
}
