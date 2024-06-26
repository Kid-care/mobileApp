import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/share/about_us.dart';
import 'package:healthcare/user/Services/profile_cubit.dart';
import 'package:healthcare/user/Views/family_disease_user.dart';
import 'package:healthcare/user/Views/fullcheck_screen_user.dart';
import 'package:healthcare/user/Views/history_disease_screen.dart';
import 'package:healthcare/user/Views/login_screen.dart';
import 'package:healthcare/user/Views/vaccinations_home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomEndDrawer extends StatelessWidget {
  void signOut(BuildContext context, SharedPreferences prefs) async {
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 235,
      child: ListView(
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              // ignore: sort_child_properties_last
              child: GestureDetector(
                child: Row(
                  children: [
                    GestureDetector(
                      child: const CircleAvatar(
                        backgroundColor: Color(0xffB4B4B4),
                        radius: 15,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      BlocProvider.of<ProfileCubit>(context)
                              .userModel
                              ?.userName ??
                          "",
                      style: const TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: const Center(
                child: Text(
              'التطعيمات',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreenVaccinations(),
                ),
              );
            },
          ),
          ListTile(
            title: const Center(
                child: Text('الأمراض الوراثية',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w600))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomethreeScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Center(
                child: Text('الفحص الكامل',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w600))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreens(),
                ),
              );
            },
          ),
          ListTile(
            title: const Center(
                child: Text('التاريخ المرضى',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w600))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: const Center(
                child: Text('معلومات عنا',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w600))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TeamInfoPage(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xff28CC9E),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff000000).withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: MaterialButton(
                elevation: 0,
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  context.read<ProfileCubit>().clearProfileData();
                  signOut(context, prefs);
                },
                textColor: const Color(0xff132F2B),
                child: const FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('تسجيل الخروج',
                        style: TextStyle(
                          color: Color(0xff132F2B),
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
