import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/admin/Services/profile_user_cubit.dart';
import 'package:healthcare/admin/Views/family_disease_admin.dart';
import 'package:healthcare/admin/Views/full_check_admin.dart';
import 'package:healthcare/admin/Views/history_category_screen.dart';
import 'package:healthcare/admin/Views/user_login.dart';
import 'package:healthcare/admin/Views/vaccition_admin.dart';
import 'package:healthcare/share/about_us.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminEndDrawer extends StatelessWidget {
  void signOutUser(BuildContext context, SharedPreferences prefs) async {
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => UserLoginScreen(),
      ),
    );
  }

  // final cubit = BlocProvider.of<ProfileCubit>(context);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 235,
      child: ListView(
        // padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 100,
            child: DrawerHeader(
              // ignore: sort_child_properties_last
              child: GestureDetector(
                child: Row(
                  children: [
                    GestureDetector(
                      child: CircleAvatar(
                        backgroundColor: Color(0xffB4B4B4),
                        radius: 15,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(
                      BlocProvider.of<ProfileUserCubit>(context)
                              .userModel
                              ?.userName ??
                          "",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
          ),
          ListTile(
            title: Center(
                child: Text(
              'التطعيمات',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            )),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdminVaccination(),
                ),
              );
            },
          ),
          ListTile(
            title: Center(
                child: Text('الأمراض الوراثية',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w600))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FamilyRecord(),
                ),
              );
            },
          ),
          ListTile(
            title: Center(
                child: Text('الفحص الكامل',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w600))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullCheckScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Center(
                child: Text('التاريخ المرضى',
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w600))),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiseaseAdminContent(),
                ),
              );
            },
          ),
          ListTile(
            title: Center(
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
                color: Color(0xff28CC9E),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff000000).withOpacity(0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: MaterialButton(
                elevation: 0,
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  context.read<ProfileUserCubit>().clearProfileData();
                  signOutUser(context, prefs);
                },
                textColor: Color(0xff132F2B),
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: const Text('تسجيل الخروج',
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
