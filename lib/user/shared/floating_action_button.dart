import 'package:flutter/material.dart';

class FloatingActionButtonWidget extends StatelessWidget {
  final Function() onPressed;

  FloatingActionButtonWidget({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Image.asset(
        'assets/Images/chaticon.png',
        width: 30,
        height: 30,
        color: Colors.white,
      ),
      backgroundColor: Color(0xff196B69),
    );
  }
}
