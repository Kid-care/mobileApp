import 'package:flutter/material.dart';
import 'package:healthcare/admin/Views/item_in_history_disease_admin.dart';
import 'package:healthcare/admin/shared/admin_enddrawer.dart';
import 'package:healthcare/user/shared/appbar.dart';

class DiseaseAdminContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "التاريخ المرضي",
      ),
      endDrawer: AdminEndDrawer(),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 2,
            ),
            ItemOfDiseasAdmin(),
            SizedBox(height: 7),
          ],
        ),
      ),
    );
  }
}
