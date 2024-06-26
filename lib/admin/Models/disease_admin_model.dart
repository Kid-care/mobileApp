import 'package:intl/intl.dart';

class DiseaseAdmin {
  final String name;
  final String? advice;
  final String doctor;
  final DateTime date;
  final String id;

  DiseaseAdmin({
    required this.name,
    required this.advice,
    required this.doctor,
    required this.date,
    required this.id,
  });

  factory DiseaseAdmin.fromJson(Map<String, dynamic> json) {
    String dateString = json['createdAt'];
    String firstTenCharacters = dateString.substring(0, 10);
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(firstTenCharacters));

    return DiseaseAdmin(
      name: json['name'],
      advice: json.containsKey('advice') ? json['advice'] : null,
      doctor: json['doctor'],
      date: DateTime.parse(formattedDate),
      id: json['_id'],
    );
  }
}
