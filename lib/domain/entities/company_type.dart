import 'package:zona0_apk/presentation/widgets/inputs/custom_dropdown_button.dart';

class CompanyType with DropItem {
  String type;
  CompanyType(this.type);

  @override
  String get titleDrop => type;

  @override
  String toString() => 'CompanyType(type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompanyType &&
      other.type == type;
  }

  @override
  int get hashCode => type.hashCode;
}
