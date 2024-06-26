import 'package:flutter/material.dart';
import 'package:healthcare/admin/shared/add_diseas.dart';
import 'package:healthcare/admin/shared/admin_enddrawer.dart';
import 'package:healthcare/user/shared/appbar.dart';

class AddMedicalDiagnosPage extends StatefulWidget {
  @override
  _AddMedicalDiagnosPageState createState() => _AddMedicalDiagnosPageState();
}

class _AddMedicalDiagnosPageState extends State<AddMedicalDiagnosPage> {
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
        title: "اضافة التشخيصات الطبية",
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
                categoryId: '663a30f85bfb6ddbdb483a6d',
                pageTitle: 'التشخيصات الطبية',
                apiUrl: 'http://3.129.148.71:3000/api/v1/Admin/create_Item',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
