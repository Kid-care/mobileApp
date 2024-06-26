import 'package:flutter/material.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:healthcare/user/shared/end_drawer.dart';

class AnalysisResultScreen extends StatelessWidget {
  final String analysisResult;

  AnalysisResultScreen({required this.analysisResult});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "التقرير",
      ),
      endDrawer: CustomEndDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('تم تحليل الصوره بنجاح'),
            Image.asset('assets/Images/Group (2).png'),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 17, top: 5, bottom: 10),
              child: Center(
                child: Text(
                  analysisResult,
                  style: TextStyle(fontSize: 14),
                  //textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
