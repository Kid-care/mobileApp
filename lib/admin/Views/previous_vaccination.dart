import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthcare/admin/Models/vaccine_model.dart';
import 'package:healthcare/admin/shared/admin_enddrawer.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PreviousVaccinationsPage extends StatefulWidget {
  @override
  _PreviousVaccinationsPageState createState() =>
      _PreviousVaccinationsPageState();
}

class _PreviousVaccinationsPageState extends State<PreviousVaccinationsPage> {
  List<Vaccination> previousVaccinations = [];

  @override
  void initState() {
    super.initState();
    fetchPreviousVaccinations();
  }

  Future<void> fetchPreviousVaccinations() async {
    String apiUrl = 'http://3.129.148.71:3000/api/v1/Admin/getItemsByCategory';
    String categoryId = '66266c65a068dc4d7041b9fa';

    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'user': userId!,
          'category': categoryId,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        setState(() {
          previousVaccinations =
              data.map((vaccine) => Vaccination.fromJson(vaccine)).toList();
        });
      } else {
        print('Failed to fetch previous vaccinations: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception occurred while fetching previous vaccinations: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "التطعيمات السابقة",
      ),
      endDrawer: AdminEndDrawer(),
      body: ListView.builder(
        itemCount: previousVaccinations.length,
        itemBuilder: (context, index) {
          return VaccinationItem(previousVaccinations[index]);
        },
      ),
    );
  }
}

class VaccinationItem extends StatelessWidget {
  final Vaccination vaccination;

  VaccinationItem(this.vaccination);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 6.5),
        ],
        // border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            vaccination.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '${DateFormat('yyyy-MM-dd').format(vaccination.createdAt)}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
