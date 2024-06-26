import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  BottomNavigationBarWidget({
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
      ),
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xff28CC9E).withOpacity(0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildNavigationItem(Icons.home, 'الصفحة الرئيسية', 1, context),
            buildEmptySpace(),
            buildNavigationItem(Icons.person, 'الملف الشخصي', 3, context),
          ],
        ),
      ),
    );
  }

  Widget buildNavigationItem(
      IconData icon, String title, int index, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(
            icon,
            size: 35,
            color: selectedIndex == index
                ? Colors.black
                : Colors.black.withOpacity(0.5),
          ),
          onPressed: () {
            onItemSelected(index);
          },
        ),
        GestureDetector(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: selectedIndex == index
                  ? Colors.black
                  : Colors.black.withOpacity(0.5),
            ),
          ),
          onTap: () {
            onItemSelected(index);
          },
        ),
      ],
    );
  }

  Widget buildEmptySpace() {
    return const SizedBox(
      height: 6,
    );
  }
}
