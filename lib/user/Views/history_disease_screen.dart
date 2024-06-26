import 'package:flutter/material.dart';
import 'package:healthcare/user/Views/chat_screen.dart';
import 'package:healthcare/user/Views/home_screen.dart';
import 'package:healthcare/user/Views/profile_screen.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:healthcare/user/shared/item_in_history_diseas.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    DiseaseContent(),
    const HomeScreen(),
    ChatScreen(), // Replace Placeholder() with your MessageScreen()
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

class DiseaseContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: " التاريخ المرضي ",
      ),
      endDrawer: CustomEndDrawer(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ItemOfDiseas(),
            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}
