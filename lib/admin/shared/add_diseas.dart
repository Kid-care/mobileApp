import 'package:flutter/material.dart';
import 'package:healthcare/share/constant.dart';
import 'package:http/http.dart' as http;

class AddDisease extends StatelessWidget {
  final TextEditingController diseaseController;
  final TextEditingController doctorController;
  final TextEditingController notesController;
  final String categoryId;
  final String pageTitle;
  final String apiUrl;

  const AddDisease({
    Key? key,
    required this.diseaseController,
    required this.doctorController,
    required this.notesController,
    required this.categoryId,
    required this.pageTitle,
    required this.apiUrl,
  }) : super(key: key);

  Future<void> _submitData(BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'user': userId!,
          'category': categoryId,
        },
        body: {
          'name': diseaseController.text,
          'doctor': doctorController.text,
          'advice': notesController.text,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تمت إضافة $pageTitle بنجاح'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${response.body}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Exception occurred while submitting data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: diseaseController,
          decoration: InputDecoration(
            labelText: 'اسم المرض',
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 13.0,
            ),
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
          controller: doctorController,
          decoration: InputDecoration(
            labelText: 'اسم الدكتور',
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 13.0,
            ),
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
          controller: notesController,
          decoration: InputDecoration(
            labelText: 'الملاحظات والعلاج',
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 13.0,
            ),
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
          maxLines: 9,
        ),
        const SizedBox(height: 200),
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
            onTap: () => _submitData(context),
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
    );
  }
}
