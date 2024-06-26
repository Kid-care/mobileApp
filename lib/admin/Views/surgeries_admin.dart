import 'package:flutter/material.dart';
import 'package:healthcare/admin/Models/disease_admin_model.dart';
import 'package:healthcare/admin/Views/add_surgeries.dart';
import 'package:healthcare/admin/shared/admin_enddrawer.dart';
import 'package:healthcare/admin/shared/disease_item_admin.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Surgeries extends StatefulWidget {
  @override
  _SurgeriesState createState() => _SurgeriesState();
}

class _SurgeriesState extends State<Surgeries> {
  List<DiseaseAdmin> diseases = [];

  @override
  void initState() {
    super.initState();
    fetchDiseases();
  }

  Future<void> deleteDisease(String diseaseId) async {
    String apiUrl = 'https://kid-care.onrender.com/api/v1/Admin/deleteItem';
    String categoryId =
        '6626784f9ad7dd36168b89f0'; // Replace with your categoryId

    try {
      var response = await http.delete(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'user': userId!, // Replace with your user id
          'item': diseaseId,
          'category': categoryId,
        },
      );
      if (response.statusCode == 200) {
        print('${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("تم الحذف بنجاح"),
          ),
        );
        // Refresh the list to reflect the changes
        fetchDiseases();
      } else {
        print('${response.body}');
      }
    } catch (e) {
      print('حدث استثناء أثناء محاولة حذف المرض: $e');
    }
  }

  Future<void> fetchDiseases() async {
    String apiUrl = 'http://3.129.148.71:3000/api/v1/Admin/getItemsByCategory';
    String categoryId =
        '6626784f9ad7dd36168b89f0'; // Replace with your categoryId

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
        List<DiseaseAdmin> diseases =
            data.map((disease) => DiseaseAdmin.fromJson(disease)).toList();
        print(diseases);
        setState(() {
          this.diseases = diseases;
        });
      } else {
        print('Failed to fetch diseases: ${response.body}');
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
        title: "العمليات الجراحية",
      ),
      endDrawer: AdminEndDrawer(),
      body: ListView.builder(
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          return DiseaseItemAdmin(
              disease: diseases[index], onDelete: deleteDisease);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddSurgeriesPage(),
              ),
            ).then((_) {
              // Refresh data on return from add page
              fetchDiseases();
            });
          },
          child: Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
          backgroundColor: Color(0xff196B69),
        ),
      ),
    );
  }
}
