import 'package:flutter/material.dart';

class App extends StatefulWidget {
  final Function(String) onBloodTypeSelected;
  const App({required this.onBloodTypeSelected});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late String selected;
  List<String> bloodTypes = ['+A', '-B', '+O', '+AB', '-A', '+B', '-AB', '-O'];
  List<String> images = [
    "assets/Images/Vector (2).png",
    "assets/Images/Vector (2).png",
    "assets/Images/Vector (2).png",
    "assets/Images/Vector (2).png",
    "assets/Images/Vector (2).png",
    "assets/Images/Vector (2).png",
    "assets/Images/Vector (2).png",
    "assets/Images/Vector (2).png",
  ];
  List<bool> isSelected = List.generate(8, (index) => false);
  //ValueNotifier<int> selectedBloodTypeIndexNotifier = ValueNotifier<int>(-1);

  @override
  Widget build(BuildContext context) {
    List<Widget> bloodTypeWidgets = List.generate(8, (index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected[index]) {
              isSelected[index] = false;
              images[index] = "assets/Images/Vector (2).png";
              // selected = ''; // الصورة الأصلية
            } else {
              // تم النقر على العنصر لأول مرة
              for (var i = 0; i < isSelected.length; i++) {
                if (i != index) {
                  isSelected[i] = false; // إلغاء تحديد كل العناصر الأخرى
                  images[i] =
                      "assets/Images/Vector (2).png"; // الصورة الأصلية للعناصر الأخرى
                } else if (i == index) {
                  isSelected[i] = true;
                  images[i] = "assets/Images/Vector.png";
                  switch (i) {
                    case 0:
                      selected = "A+";
                      break;
                    case 1:
                      selected = "B-";
                      break;
                    case 2:
                      selected = "O+";
                      break;
                    case 3:
                      selected = "AB+";
                      break;
                    case 4:
                      selected = "A-";
                      break;
                    case 5:
                      selected = "B+";
                      break;
                    case 6:
                      selected = "AB-";
                      break;
                    case 7:
                      selected = "O-";
                      break;
                  }
                  widget.onBloodTypeSelected(selected);
                }
              }
              //         isSelected[index] = true;
              //         images[index] = "assets/Images/Vector.png";
              //           switch (index) {
              //   case 0:
              //     selected = "A+";
              //     break;
              //   case 1:
              //     selected = "B-";
              //     break;
              //   case 2:
              //     selected = "O+";
              //     break;
              //   case 3:
              //     selected = "AB+";
              //     break;
              //   case 4:
              //     selected = "A-";
              //     break;
              //   case 5:
              //     selected = "B+";
              //     break;
              //   case 6:
              //     selected = "AB-";
              //     break;
              //   case 7:
              //     selected = "O-";
              //     break;
              //   default:
              //     selected = '';
              // }
              // التغيير المطلوب
            }
          });
        },
        child: Container(
          margin: EdgeInsets.all(8),
          child: Stack(
            children: <Widget>[
              Image.asset(
                images[index],
                width: 50,
                height: 50,
              ),
              Positioned(
                top: 14,
                left: 10,
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Container(
                    color: Colors.white.withOpacity(0),
                    child: Text(
                      bloodTypes[index],
                      style: TextStyle(
                        fontSize: 13,
                        color: isSelected[index] ? Colors.white : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });

    List<Widget> rows = [];
    for (var i = 0; i < bloodTypeWidgets.length; i += 4) {
      var endIndex =
          i + 4 < bloodTypeWidgets.length ? i + 4 : bloodTypeWidgets.length;
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: bloodTypeWidgets.sublist(i, endIndex),
      ));
    }
    return SingleChildScrollView(
      child: Column(
        children: rows,
      ),
    );
  }
}
