import 'package:flutter/material.dart';

class Boarding extends StatelessWidget {
  final Color backgroundColor;
  final String imagePass;
  final String title;
  final String text;

  const Boarding({
    required this.backgroundColor,
    required this.imagePass,
    required this.text,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          Image.asset(
            imagePass,
            height: MediaQuery.of(context).size.height * 0.50,
            width: double.infinity,
          ),
          const SizedBox(
            height: 0.5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 20,
              color: Color(0xff132F2B),
            ),
          ),
          const SizedBox(
            height: 3.5,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xff132F2B).withOpacity(0.8),
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
