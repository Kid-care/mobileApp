import 'package:intl/intl.dart';

class Vaccination {
  final String name;
  final DateTime createdAt;

  Vaccination({
    required this.name,
    required this.createdAt,
  });

  factory Vaccination.fromJson(Map<String, dynamic> json) {
    String dateString = json['createdAt'];
    String firstTenCharacters = dateString.substring(0, 10);

    String formattedDate =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(firstTenCharacters));
    return Vaccination(
      name: json['name'],
      createdAt: DateTime.parse(formattedDate),
    );
  }
}
