import 'package:flutter/material.dart';
import 'package:healthcare/admin/Models/disease_admin_model.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class DiseaseItemAdmin extends StatefulWidget {
  final DiseaseAdmin disease;
  final Function(String) onDelete;

  DiseaseItemAdmin({required this.disease, required this.onDelete, Key? key})
      : super(key: key);

  @override
  _DiseaseItemAdminState createState() => _DiseaseItemAdminState();
}

class _DiseaseItemAdminState extends State<DiseaseItemAdmin> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        GestureDetector(
          onLongPress: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("تأكيد الحذف"),
                  content: const Text("هل أنت متأكد أنك تريد حذف هذا العنصر؟"),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close dialog
                      },
                      child: const Text("إلغاء"),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onDelete(
                            widget.disease.id); // Execute delete function
                        Navigator.of(context)
                            .pop(); // Close dialog after deletion
                      },
                      child: const Text("حذف"),
                    ),
                  ],
                );
              },
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(vertical: 4),
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
                          child: const Icon(Icons.arrow_forward_ios_outlined),
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
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(14),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('العلاج: ${widget.disease.advice}'),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('دكتور: ${widget.disease.doctor}'),
                    Text(
                      '${DateFormat('yyyy-MM-dd').format(widget.disease.date)}',
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
