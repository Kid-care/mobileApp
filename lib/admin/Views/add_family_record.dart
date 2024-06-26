import 'package:flutter/material.dart';
import 'package:healthcare/admin/shared/admin_enddrawer.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/user/shared/appbar.dart';
import 'package:http/http.dart' as http;

class AddFamilyRecordPage extends StatefulWidget {
  @override
  _AddFamilyRecordPageState createState() => _AddFamilyRecordPageState();
}

class _AddFamilyRecordPageState extends State<AddFamilyRecordPage> {
  final TextEditingController _diseaseController = TextEditingController();

  final TextEditingController _notesController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _submitData() async {
    String apiUrl = 'http://3.129.148.71:3000/api/v1/Admin/create_Item';
    String categoryId = '66266c65a068dc4d7041ba00';

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'user': userId!,
          'category': categoryId,
        },
        body: {
          'name': _diseaseController.text,
          'advice': _notesController.text,
        },
      );

      if (response.statusCode == 200) {
        // يتم التعامل مع الاستجابة من الخادم هنا
        print('Data submitted successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تمت إضافة المرض بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        // في حالة حدوث خطأ أثناء إرسال البيانات
        print(' ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Exception occurred while submitting data: $e');
      print('yes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "اضافة الامراض العائلية",
      ),
      endDrawer: AdminEndDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _diseaseController,
                decoration: InputDecoration(
                  labelText: 'اسم المرض',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 13.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff28CC9E)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xff28CC9E),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _notesController,
                decoration: InputDecoration(
                  labelText: 'الملاحظات والعلاج',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 13.0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff28CC9E)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: Color(0xff28CC9E),
                    ),
                  ),
                ),
                maxLines: 10,
              ),
              const SizedBox(height: 250),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xff28CC9E),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff000000).withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: _submitData,
                  child: const Center(
                    child: Text(
                      'اضافة',
                      style: TextStyle(
                        color: Color(0xff132F2B),
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
