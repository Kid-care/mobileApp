import 'package:flutter/material.dart';
import 'package:healthcare/user/Models/vaccine_model.dart';
import 'package:healthcare/user/Views/chat_screen.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryVaccinations extends StatefulWidget {
  @override
  _CountryVaccinationsState createState() => _CountryVaccinationsState();
}

class _CountryVaccinationsState extends State<CountryVaccinations> {
  List<VaccineCategory> vaccineCategories = [];

  @override
  void initState() {
    super.initState();
    fetchVaccineCategories();
  }

  Future<void> fetchVaccineCategories() async {
    String apiUrl = 'http://3.129.148.71:3000/api/v1/Item/get_Item';
    try {
      var response = await http.get(Uri.parse(apiUrl),
          headers: <String, String>{'category': '6628fb667fa22e55072ca293'});
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<VaccineCategory> categories =
            data.map((category) => VaccineCategory.fromJson(category)).toList();
        setState(() {
          vaccineCategories = categories;
        });
      } else {
        print('Failed to fetch vaccine categories: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred while fetching vaccine categories: $e');
    }
  }

  Future<List<Vaccine>> fetchVaccines(String categoryId) async {
    String apiUrl =
        'http://3.129.148.71:3000/api/v1/Item/get_Item'; // تعديل: استبدل بعنوان URL الصحيح للـ API
    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'category': categoryId,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Vaccine> vaccines =
            data.map((vaccine) => Vaccine.fromJson(vaccine)).toList();
        return vaccines;
      } else {
        print(
            'Failed to fetch vaccines for category $categoryId: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception occurred while fetching vaccines: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "تطعيمات المسافرين",
      ),
      endDrawer: CustomEndDrawer(),
      body: ListView.builder(
        itemCount: vaccineCategories.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const SizedBox(height: 10),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 6.5),
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ExpansionTile(
                  title: ListTile(
                    title: Text(vaccineCategories[index].name),
                  ),
                  children: [
                    FutureBuilder(
                      future: fetchVaccines(vaccineCategories[index].id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          List<Vaccine> vaccines =
                              snapshot.data as List<Vaccine>;
                          return Column(
                            children: vaccines.map((vaccine) {
                              return ListTile(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(vaccine.name),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ChatScreen(),
                                          ),
                                        );
                                      },
                                      child: const Row(
                                        children: [
                                          Text('المزيد'),
                                          Icon(Icons.arrow_forward),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
