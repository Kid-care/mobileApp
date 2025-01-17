import 'dart:convert';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:healthcare/user/Models/disease_model.dart';
import 'package:healthcare/user/shared/disease_column.dart';

class ChronicDiseaseUser extends StatefulWidget {
  @override
  _ChronicDiseaseUserState createState() => _ChronicDiseaseUserState();
}

class _ChronicDiseaseUserState extends State<ChronicDiseaseUser> {
  List<Disease> diseases = [];

  @override
  void initState() {
    super.initState();
    fetchDiseases();
  }

  Future<void> fetchDiseases() async {
    String apiUrl = 'http://3.129.148.71:3000/api/v1/Admin/getItemsByCategory';
    String categoryId = '66266c73a068dc4d7041b9fd';

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
        List<Disease> diseases =
            data.map((disease) => Disease.fromJson(disease)).toList();
        setState(() {
          this.diseases = diseases;
        });
      } else {
        print('Failed to fetch diseases: ${response.body}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred while fetching diseases: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "الامراض المزمنة",
      ),
      endDrawer: CustomEndDrawer(),
      body: ListView.builder(
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          return DiseaseItemUser(diseases[index]);
        },
      ),
    );
  }
}
