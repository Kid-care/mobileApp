import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLeadingPressed;
  final String title;

  const MyAppBar({
    Key? key,
    required this.onLeadingPressed,
    required this.title,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(65); // Define preferred size

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        // height: preferredSize.height,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 40, left: 15, right: 15),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          gradient: LinearGradient(
            colors: [
              const Color(0xff28CC2F).withOpacity(0.3),

              const Color(0xff28CC9E).withOpacity(0.6), // First color
              // Second color
              // Third color
              // Fourth color
            ],
            stops: [0.2, 1.0], // Stops for each color
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                size: 30,
              ),
              onPressed: onLeadingPressed,
            ),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Color(0xff000000),
              ),
            ),
            const SizedBox(
              width: 40,
            ),
          ],
        ),
      ),
    );
  }
}
