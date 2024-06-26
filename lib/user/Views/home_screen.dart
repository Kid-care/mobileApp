import 'package:flutter/material.dart';
import 'package:healthcare/user/Views/chat_screen.dart';
import 'package:healthcare/user/Views/profile_screen.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:healthcare/user/shared/item_in_home.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    ChatScreen(),
    ProfileScreen(),
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
        },
        child: Image.asset(
          'assets/Images/chaticon.png',
          width: 40,
          height: 40,
          color: _selectedIndex == 1 ? Colors.black : Colors.white,
        ),
        backgroundColor: const Color(0xff196B69),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
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
            const SizedBox(width: 50),
            Image.asset(
              'assets/Images/logo.png',
              width: 85,
            ),
            const SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
      endDrawer: CustomEndDrawer(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: 30,
            // ),
            SizedBox(
              height: 7,
            ),
            RowItemWidget(),
            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}
