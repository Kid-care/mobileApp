import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthcare/admin/shared/admin_enddrawer.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/user/Views/full_screen_of_image.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:http/http.dart' as http;

class FullCheckScreen extends StatefulWidget {
  @override
  _FullCheckScreenState createState() => _FullCheckScreenState();
}

class _FullCheckScreenState extends State<FullCheckScreen> {
  List<String> _imageUrls = [];

  Future<void> _fetchImagesFromServer() async {
    final url = Uri.parse('http://3.129.148.71:3000/api/v1/getPhotosAdmin');
    try {
      final response = await http.get(
        url,
        headers: {
          'authorization': adminToken!,
          'id': userId!,
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['photos'];
        setState(() {
          _imageUrls = data.map((photos) => photos['url'] as String).toList();
          print('Image URLs: $_imageUrls');
        });
      } else {}
    } catch (e) {}
  }

  Future<void> _refreshImages() async {
    await _fetchImagesFromServer();
    setState(() {});
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
      endDrawer: AdminEndDrawer(),
      body: ListView(
        children: [
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
    );
  }
}
