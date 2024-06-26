import 'package:flutter/material.dart';
import 'package:healthcare/admin/Views/previous_vaccination.dart';
import 'package:healthcare/user/Views/chat_screen.dart';
import 'package:healthcare/user/Views/children_vaccination.dart';
import 'package:healthcare/user/Views/country_vaccination.dart';
import 'package:healthcare/user/Views/epidemics_vaccinations.dart';
import 'package:healthcare/user/Views/home_screen.dart';
import 'package:healthcare/user/Views/pregnant_vaccination.dart';
import 'package:healthcare/user/Views/profile_screen.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:healthcare/user/shared/bottomnavbar.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:healthcare/user/shared/floating_action_button.dart';

class HomeScreenVaccinations extends StatefulWidget {
  const HomeScreenVaccinations({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenVaccinationsState createState() => _HomeScreenVaccinationsState();
}

class _HomeScreenVaccinationsState extends State<HomeScreenVaccinations> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    VaccinationScreen(),
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

class VaccinationScreen extends StatefulWidget {
  @override
  _VaccinationScreenState createState() => _VaccinationScreenState();
}

class _VaccinationScreenState extends State<VaccinationScreen> {
  List<String> vaccaion = [
    'الاطفال',
    'الحوامل',
    'السفر',
    'الاوبئه',
  ];
  List<String> images = [
    'assets/Images/Rectangle 39.png',
    'assets/Images/Rectangle 40.png',
    'assets/Images/Rectangle 41.png',
    'assets/Images/Rectangle 42.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "التطعيمات", // تمرير العنوان هنا
      ),
      endDrawer: CustomEndDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'انواع التطعيمات',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: Text(
                        'التطعيمات السابقه',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7), fontSize: 14),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PreviousVaccinationsPage(),
                          ),
                        );
                      },
                    ),
                    const Icon(
                      Icons.history,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Column(
            children: [
              for (int i = 0; i < 4; i++)
                GestureDetector(
                  onTap: () {
                    if (i == 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VaccinationSchedule(),
                        ),
                      );
                    } else if (i == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PregnantVaccinations(),
                        ),
                      );
                    } else if (i == 2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CountryVaccinations(),
                        ),
                      );
                    } else if (i == 3) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EpidemicsVaccinations(),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Container(
                      height: 170,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff475268).withOpacity(0.3),
                            blurRadius: 5,
                            spreadRadius: 1,
                          )
                        ],
                        image: DecorationImage(
                          image: AssetImage(images[i]),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      vaccaion[i],
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffFFFFFF),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
