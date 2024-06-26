import 'package:flutter/material.dart';
import 'package:healthcare/user/Views/chat_screen.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EpidemicsVaccinations extends StatefulWidget {
  @override
  _EpidemicsVaccinationsState createState() => _EpidemicsVaccinationsState();
}

class _EpidemicsVaccinationsState extends State<EpidemicsVaccinations> {
  List<dynamic> vaccines = [];

  @override
  void initState() {
    super.initState();
    fetchVaccines();
  }

  Future<void> fetchVaccines() async {
    String apiUrl = 'http://3.129.148.71:3000/api/v1/Item/get_Item';
    String categoryId = '6664d153066089b0f8abed6c';

    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'category': categoryId,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<dynamic> vaccines =
            data.map((vaccine) => vaccine['name']).toList();
        setState(() {
          this.vaccines = vaccines;
        });
      } else {
        print('Failed to fetch vaccines: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred while fetching vaccines: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "تطعيمات الاوبئة",
      ),
      endDrawer: CustomEndDrawer(),
      body: ListView.builder(
        itemCount: vaccines.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            padding: const EdgeInsets.all(10),
            height: 60,
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(vaccines[index]),
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
        },
      ),
    );
  }
}
