import 'package:flutter/material.dart';
import 'package:healthcare/user/Models/disease_model.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

class DiseaseItemUser extends StatefulWidget {
  final Disease disease;

  DiseaseItemUser(this.disease);

  @override
  _DiseaseItemUserState createState() => _DiseaseItemUserState();
}

class _DiseaseItemUserState extends State<DiseaseItemUser> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 6,
        ),
        Container(
          height: 60,
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
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
                      child: const Icon(Icons.arrow_forward_ios_outlined),
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
                Text('النصائح: ${widget.disease.advice ?? 'لا يوجد'}'),
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
