class DiseaseA {
  final String name;
  final String? advice;
  final String id;

  DiseaseA({
    required this.name,
    required this.advice,
    required this.id,
  });

  factory DiseaseA.fromJson(Map<String, dynamic> json) {
    return DiseaseA(
      name: json['name'],
      advice: json.containsKey('advice') ? json['advice'] : null,
      id: json['_id'],
    );
  }
}
