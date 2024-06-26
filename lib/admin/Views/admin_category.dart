import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/admin/Services/profile_user_cubit.dart';
import 'package:healthcare/admin/Views/item_in_home_admin.dart';
import 'package:healthcare/admin/Views/profile_admin_screen.dart';
import 'package:healthcare/admin/Views/user_login.dart';
import 'package:healthcare/admin/shared/admin_enddrawer.dart';
import 'package:healthcare/user/Views/chat_screen.dart';
import 'package:healthcare/user/Views/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeAdmin(),
    ChatScreen(),
    const ProfileAdminScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: const Color(0xff28CC9E).withOpacity(0.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.home,
                        size: 28,
                        color: _selectedIndex == 0
                            ? Colors.black
                            : Colors.black.withOpacity(0.5)),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                  GestureDetector(
                    child: Text('الصفحه الرئيسيه',
                        style: TextStyle(
                          color: _selectedIndex == 0
                              ? Colors.black
                              : Colors.black.withOpacity(0.5),
                        )),
                    onTap: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 6,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text('مساعدك الذكى',
                      style: TextStyle(
                        color: _selectedIndex == 1
                            ? Colors.black
                            : Colors.black.withOpacity(0.5),
                      )),
                ],
              ),
              const SizedBox(), // Empty SizedBox for the notched space
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.person,
                        size: 28,
                        color: _selectedIndex == 2
                            ? Colors.black
                            : Colors.black.withOpacity(0.5)),
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 2;
                      });
                    },
                  ),
                  GestureDetector(
                      child: Text(
                        'الملف الشخصى',
                        style: TextStyle(
                          color: _selectedIndex == 2
                              ? Colors.black
                              : Colors.black.withOpacity(0.5),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _selectedIndex = 2;
                        });
                      }),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(),
            ),
          );
        }, // Define onPressed as needed
        child: Image.asset(
          'assets/Images/chaticon.png',
          width: 25,
          height: 25,
          color: _selectedIndex == 1 ? Colors.black : Colors.white,
        ),
        backgroundColor: const Color(0xff196B69),
      ),
    );
  }
}

class HomeAdmin extends StatelessWidget {
  void signOutAdmin(BuildContext context, SharedPreferences prefs) async {
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
  }

  void signOutUser(BuildContext context, SharedPreferences prefs) async {
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => UserLoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              child: const Text(
                ' الخروج من البيانات',
                style: TextStyle(fontSize: 15),
              ),
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                signOutAdmin(context, prefs);
              },
            ),
            Image.asset(
              'assets/Images/logo.png',
              width: 80,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
      endDrawer: AdminEndDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
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
                    context.read<ProfileUserCubit>().clearProfileData();
                    signOutUser(context, prefs);
                  },
                  textColor: const Color(0xff132F2B),
                  child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text('تسجيل مريض اخر',
                          style: TextStyle(
                            color: Color(0xff132F2B),
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ))),
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const AdminRowItemWidget(),
            const SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}
