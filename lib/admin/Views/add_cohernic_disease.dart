import 'package:flutter/material.dart';
import 'package:healthcare/admin/shared/add_diseas.dart';
import 'package:healthcare/admin/shared/admin_enddrawer.dart';
import 'package:healthcare/user/shared/appbar.dart';

class AddRecordPage extends StatefulWidget {
  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  final TextEditingController _diseaseController = TextEditingController();
  final TextEditingController _doctorController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "اضافة الامراض المزمنة",
      ),
      endDrawer: AdminEndDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AddDisease(
                diseaseController: _diseaseController,
                doctorController: _doctorController,
                notesController: _notesController,
                categoryId: '66266c73a068dc4d7041b9fd',
                pageTitle: 'المرض المزمن',
                apiUrl: 'http://3.129.148.71:3000/api/v1/Admin/create_Item',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
