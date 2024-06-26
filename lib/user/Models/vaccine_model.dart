class Vaccine {
  final String name;

  Vaccine(this.name);

  factory Vaccine.fromJson(Map<String, dynamic> json) {
    return Vaccine(
      json['name'],
    );
  }
}

class VaccineCategory {
  final String id;
  final String name;

  VaccineCategory(this.id, this.name);

  factory VaccineCategory.fromJson(Map<String, dynamic> json) {
    return VaccineCategory(
      json['_id'],
      json['name'],
    );
  }
}
