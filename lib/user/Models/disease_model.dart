import 'package:intl/intl.dart';

class Disease {
  final String name;
  final String? advice;
  final String doctor;
  final DateTime date;

  Disease({
    required this.name,
    required this.advice,
    required this.doctor,
    required this.date,
  });

  factory Disease.fromJson(Map<String, dynamic> json) {
    String dateString = json['createdAt'];
    String firstTenCharacters = dateString.substring(0, 10);
    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(firstTenCharacters));

    return Disease(
      name: json['name'],
      advice: json.containsKey('advice') ? json['advice'] : null,
      doctor: json['doctor'],
      date: DateTime.parse(formattedDate),
    );
  }
}
