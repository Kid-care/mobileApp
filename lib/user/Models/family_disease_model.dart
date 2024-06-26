class Diseases {
  final String name;
  final String? advice;

  Diseases({
    required this.name,
    required this.advice,
  });

  factory Diseases.fromJson(Map<String, dynamic> json) {
    return Diseases(
      name: json['name'],
      advice: json.containsKey('advice') ? json['advice'] : null,
    );
  }
}
