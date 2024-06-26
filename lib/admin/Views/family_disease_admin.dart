import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:healthcare/admin/Models/family_disease.dart';
import 'package:healthcare/admin/Views/add_family_record.dart';
import 'package:healthcare/admin/shared/admin_enddrawer.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/user/shared/appbar.dart';

class FamilyRecord extends StatefulWidget {
  @override
  _FamilyRecordState createState() => _FamilyRecordState();
}

class _FamilyRecordState extends State<FamilyRecord> {
  List<DiseaseA> diseases = [];

  @override
  void initState() {
    super.initState();
    fetchDiseases();
  }

  Future<void> deleteDisease(String diseaseId) async {
    String apiUrl = 'https://kid-care.onrender.com/api/v1/Admin/deleteItem';
    String categoryId = '66266c65a068dc4d7041ba00';

    try {
      var response = await http.delete(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'user': userId!,
          'item': diseaseId,
          'category': categoryId,
        },
      );
      if (response.statusCode == 200) {
        print('${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('تم الحذف بنجاح'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ));
        // قم بتحديث القائمة لعرض التغييرات الجديدة
        fetchDiseases();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('{$response.body}'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ));
      }
    } catch (e) {
      print('فشل فى حذف المرض: $e');
    }
  }

  Future<void> fetchDiseases() async {
    String apiUrl = 'http://3.129.148.71:3000/api/v1/Admin/getItemsByCategory';
    String categoryId = '66266c65a068dc4d7041ba00';

    try {
      var response = await http.get(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'user': userId!,
          'category': categoryId,
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<DiseaseA> diseases =
            data.map((disease) => DiseaseA.fromJson(disease)).toList();
        print(diseases);
        setState(() {
          this.diseases = diseases;
        });
      } else {
        print('Failed to fetch diseases: ${response.body}');
        print('Error message: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred while fetching diseases: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        onLeadingPressed: () {
          Navigator.of(context).pop();
        },
        title: "السجل العائلي", // تمرير العنوان هنا
      ),
      endDrawer: AdminEndDrawer(),
      body: ListView.builder(
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          return DiseaseItem(diseases[index], deleteDisease);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddFamilyRecordPage(),
              ),
            ).then((_) {
              // عند العودة من صفحة الإضافة، قم بتحديث البيانات
              fetchDiseases();
            });
          },
          child: Icon(
            Icons.add,
            size: 35,
            color: Colors.white,
          ),
          backgroundColor: Color(0xff196B69),
        ),
      ),
    );
  }
}

class DiseaseItem extends StatefulWidget {
  final DiseaseA disease;
  final Function(String) onDelete;

  DiseaseItem(this.disease, this.onDelete);

  @override
  _DiseaseItemState createState() => _DiseaseItemState();
}

class _DiseaseItemState extends State<DiseaseItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        GestureDetector(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("تأكيد الحذف"),
                  content: Text("هل أنت متأكد أنك تريد حذف هذا العنصر؟"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // إغلاق المربع النصي بدون حذف
                      },
                      child: Text("إلغاء"),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onDelete(widget.disease.id); // تنفيذ دالة الحذف
                        Navigator.of(context)
                            .pop(); // إغلاق المربع النصي بعد الحذف
                      },
                      child: Text("حذف"),
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: Container(
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 6.5),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                title: Text(widget.disease.name),
                trailing: IconButton(
                  icon: _isExpanded
                      ? Transform.rotate(
                          angle: math.pi / 2,
                          child: Icon(Icons.arrow_forward_ios_outlined),
                        )
                      : Transform.rotate(
                          angle: -math.pi / 2,
                          child: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                  onPressed: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        if (_isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 6.5),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'نصائح لحمياتك من مرض ${widget.disease.name}',
                      style: TextStyle(color: Color(0xff2CB438), fontSize: 17),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '${widget.disease.advice}',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
