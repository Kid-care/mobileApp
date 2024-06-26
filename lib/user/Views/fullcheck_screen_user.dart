import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/user/Views/analysis_screen.dart';
import 'package:healthcare/user/Views/chat_screen.dart';
import 'package:healthcare/user/Views/full_screen_of_image.dart';
import 'package:healthcare/user/Views/home_screen.dart';
import 'package:healthcare/user/Views/profile_screen.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:healthcare/user/shared/bottomnavbar.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:healthcare/user/shared/floating_action_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class HomeScreens extends StatefulWidget {
  const HomeScreens({Key? key}) : super(key: key);

  @override
  _HomeScreensState createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    FullCheckupScreen(),
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

class FullCheckupScreen extends StatefulWidget {
  @override
  _FullCheckupScreenState createState() => _FullCheckupScreenState();
}

class _FullCheckupScreenState extends State<FullCheckupScreen> {
  List<String> _imageUrls = [];

  Future<void> _fetchImagesFromServer() async {
    final url = Uri.parse('https://kid-care.onrender.com/api/v1/getPhotos');
    try {
      final response = await http.get(
        url,
        headers: {
          'authorization': userToken!,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['photos'];
        setState(() {
          _imageUrls = data.map((photos) => photos['url'] as String).toList();
        });
      } else {
        // // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        // //   content: Text('${response.body}'),
        // ));
      }
    } catch (e) {}
  }

  Future<void> _uploadImageToServer() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final url = Uri.parse('https://kid-care.onrender.com/api/v1/postPhoto');

      try {
        final file = File(pickedImage.path);
        final request = http.MultipartRequest('POST', url);
        request.files
            .add(await http.MultipartFile.fromPath('photo', file.path));
        request.headers['authorization'] = userToken!;
        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('تم رفع الصورة بنجاح'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ));
          // _refreshImages();
          setState(() {
            _imageUrls.add(json.decode(response.body)['url']);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${response.body}'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ));
        }
      } catch (e) {}
    }
  }

  Future<void> _refreshImages() async {
    await _fetchImagesFromServer();
    setState(() {});
  }

  Future<void> _analyzeImage() async {
    final imagePicker = ImagePicker();
    final pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      final url = Uri.parse('http://3.129.148.71:5000/extract_text');

      try {
        final file = File(pickedImage.path);
        final request = http.MultipartRequest('POST', url);
        request.headers['Content-Type'] = 'application/json';
        request.files.add(await http.MultipartFile.fromPath('file', file.path));
        // request.fields['photoUrl'] = imageUrl;

        final streamedResponse = await request.send();
        final response = await http.Response.fromStream(streamedResponse);

        if (response.statusCode == 200) {
          final analysisResult = json.decode(response.body)['report'];

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('تم تحليل الصورة بنجاح'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ));

          _showAnalysisResult(analysisResult);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${response.body}'),
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('حدث خطأ أثناء الاتصال بالخادم'),
        ));
      }
    }
  }

  void _showAnalysisResult(String result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnalysisResultScreen(analysisResult: result),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchImagesFromServer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: " الفحص الكامل ",
      ),
      endDrawer: CustomEndDrawer(),
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xff28CC2F).withOpacity(0.3),
                  const Color(0xff28CC9E).withOpacity(0.6),
                ],
                stops: [0.2, 1.0],
                begin: Alignment.topLeft,
                end: Alignment.topRight,
              ),
            ),
            child: ElevatedButton(
              onPressed: _analyzeImage,
              style: ElevatedButton.styleFrom(
                primary: Colors.transparent,
                elevation: 0,
                padding: EdgeInsets.zero,
              ),
              child: Image.asset('assets/Images/Group 180.png'),
            ),
          ),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _imageUrls.map((imageUrl) {
              return Padding(
                padding: const EdgeInsets.all(13.0),
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImage(imageUrl: imageUrl),
                        ),
                      );
                    },
                    child: Container(
                        width: double.infinity,
                        color: Colors.red,
                        child: Image.network(
                          imageUrl,
                          // fit: BoxFit.cover,
                        ))),
              );
            }).toList(),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          onPressed: _uploadImageToServer,
          child: const Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
          backgroundColor: const Color(0xff196B69),
        ),
      ),
    );
  }
}
