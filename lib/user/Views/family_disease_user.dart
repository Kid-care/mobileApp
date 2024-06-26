import 'package:flutter/material.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/user/Models/family_disease_model.dart';
import 'package:healthcare/user/Views/chat_screen.dart';
import 'package:healthcare/user/Views/home_screen.dart';
import 'package:healthcare/user/Views/profile_screen.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:healthcare/user/shared/bottomnavbar.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:healthcare/user/shared/floating_action_button.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:intl/intl.dart';
import 'dart:math' as math;

class HomethreeScreen extends StatefulWidget {
  const HomethreeScreen({Key? key}) : super(key: key);

  @override
  _HomethreeScreenState createState() => _HomethreeScreenState();
}

class _HomethreeScreenState extends State<HomethreeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    FamilyRecordUser(),
    HomeContent(),
    ChatScreen(), // Replace Placeholder() with your MessageScreen()
    ProfileScreen(),
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBarWidget(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemSelected,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButtonWidget(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(),
            ),
          );
        },
      ),
    );
  }
}

class FamilyRecordUser extends StatefulWidget {
  @override
  _FamilyRecordUserState createState() => _FamilyRecordUserState();
}

class _FamilyRecordUserState extends State<FamilyRecordUser> {
  List<Diseases> diseases = [];

  @override
  void initState() {
    super.initState();
    fetchDiseases();
  }

  Future<void> fetchDiseases() async {
    String apiUrl = 'http://3.129.148.71:3000/api/v1/Admin/getItemsByCategory';
    String categoryId = '66266c65a068dc4d7041ba00';

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
        List<Diseases> diseases =
            data.map((disease) => Diseases.fromJson(disease)).toList();
        print(diseases);
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
        title: "السجل العائلي",
      ),
      endDrawer: CustomEndDrawer(),
      body: ListView.builder(
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          return DiseaseItem(diseases[index]);
        },
      ),
    );
  }
}

class DiseaseItem extends StatefulWidget {
  final Diseases disease;

  DiseaseItem(this.disease);

  @override
  _DiseaseItemState createState() => _DiseaseItemState();
}

class _DiseaseItemState extends State<DiseaseItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
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
          child: ListTile(
            title: Text(widget.disease.name),
            trailing: IconButton(
              icon: _isExpanded
                  ? Transform.rotate(
                      angle: math.pi / 2,
                      child: const Icon(Icons.arrow_forward_ios_outlined),
                    )
                  : Transform.rotate(
                      angle: -math.pi / 2,
                      child: const Icon(Icons.arrow_forward_ios_outlined),
                    ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
            ),
          ),
        ),
        if (_isExpanded)
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
            padding: const EdgeInsets.all(6),
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
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'نصائح لحمياتك من مرض ${widget.disease.name}',
                    style:
                        const TextStyle(color: Color(0xff2CB438), fontSize: 17),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${widget.disease.advice}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
