import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthcare/admin/Views/previous_vaccination.dart';
import 'package:healthcare/admin/shared/admin_enddrawer.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:http/http.dart' as http;

class AdminVaccination extends StatefulWidget {
  const AdminVaccination({Key? key}) : super(key: key);

  @override
  State<AdminVaccination> createState() => _AdminVaccinationState();
}

class _AdminVaccinationState extends State<AdminVaccination> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> vaccinations = [];
  List<String> selectedVaccinations = [];
  TextEditingController searchController = TextEditingController();
  List<String> filteredVaccinations = [];

  @override
  void initState() {
    super.initState();
    fetchVaccinationsFromAPI();
    searchController.addListener(searchListener);
  }

  @override
  void dispose() {
    searchController.removeListener(searchListener);
    searchController.dispose();
    super.dispose();
  }

  void searchListener() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        filteredVaccinations = vaccinations
            .where((vaccine) => vaccine
                .toLowerCase()
                .contains(searchController.text.toLowerCase()))
            .toList();
      });
    });
  }

  void fetchVaccinationsFromAPI() async {
    String apiUrl = 'http://3.129.148.71:3000/api/v1/search/search_vaccines';

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode({'query': ''}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<String> fetchedVaccinations =
            List<String>.from(data['searchResult']);

        setState(() {
          vaccinations = fetchedVaccinations;
          filteredVaccinations = fetchedVaccinations;
        });
      } else {
        print(
            "Failed to fetch data from API. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception occurred while fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "التطعيمات",
      ),
      endDrawer: AdminEndDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(child: Container()),
                Row(
                  children: [
                    GestureDetector(
                        child: Text(
                          'التطعيمات السابقه',
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 14),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PreviousVaccinationsPage(),
                            ),
                          );
                        }),
                    const Icon(
                      Icons.history,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'ابحث',
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 13.0),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xff28CC9E)),
                  borderRadius: BorderRadius.circular(40),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                  borderSide: const BorderSide(
                    color: Color(0xff28CC9E),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: filteredVaccinations.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (context, index) {
                  final vaccine = filteredVaccinations[index];
                  return ListTile(
                    title: Text(vaccine),
                    trailing: Checkbox(
                      value: selectedVaccinations.contains(vaccine),
                      onChanged: (isChecked) {
                        setState(() {
                          if (isChecked!) {
                            selectedVaccinations.add(vaccine);
                          } else {
                            selectedVaccinations.remove(vaccine);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  if (selectedVaccinations.isNotEmpty) {
                    sendVaccination(selectedVaccinations.first);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('من فضلك اختار تطعيم'),
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff28CC9E),
                  padding: const EdgeInsets.all(2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(70),
                  ),
                  elevation: 4, // ارتفاع الظل
                  shadowColor: Colors.black.withOpacity(0.5),
                ),
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    'اضافة التطعيم',
                    style: TextStyle(
                      color: Color(0xff132F2B), // لون النص
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void sendVaccination(String selectedVaccination) async {
    var url = Uri.parse('http://3.129.148.71:3000/api/v1/Admin/create_Item');
    String categoryId = '66266c65a068dc4d7041b9fa';

    var requestBody = {
      'name': selectedVaccination,
    };

    var headers = {'category': categoryId, 'user': userId!};
    try {
      var response = await http.post(
        url,
        headers: headers,
        body: (requestBody),
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('تم اضافة تطعيم "$selectedVaccination" بنجاح'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("  ${response.body}"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Network error: $e'),
      ));
    }
  }
}
