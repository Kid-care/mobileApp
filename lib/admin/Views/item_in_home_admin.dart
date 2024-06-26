import 'package:flutter/material.dart';
import 'package:healthcare/admin/Views/family_disease_admin.dart';
import 'package:healthcare/admin/Views/full_check_admin.dart';
import 'package:healthcare/admin/Views/history_category_screen.dart';
import 'package:healthcare/admin/Views/vaccition_admin.dart';

class AdminRowItemWidget extends StatelessWidget {
  const AdminRowItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> shohoreNames = [
      "التطعيم المناسب لحالتك وحسب احتياجك، وأيضًا جميع التطعيمات متوفرة مع تفاصيل عنها.",
      "تسجيل و متابعة حالتك الصحية و زياراتك للطبيب بشكل دقيق و منظم.",
      "سجل فيها الأمراض المزمنة لأفراد العائلة مع نصائح للوقاية من الأمراض المزمنة",
      " نحتفظ بجميع التحاليل و الفحوصات الخاصة بصحتك بشكل منظم حتى الحاجة إليها",
    ];
    List<String> cateogry = [
      "التطعيمات",
      "التاريخ المرضى",
      "السجل العائلى",
      "الفحص الكامل",
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          for (int i = 0; i < 4; i++)
            GestureDetector(
              onTap: () {
                if (i == 0) {
                  // تحديد السلوك عند النقر على هذا النص
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminVaccination(),
                    ),
                  );
                } else if (i == 1) {
                  // تحديد السلوك عند النقر على هذا النص
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiseaseAdminContent(),
                    ),
                  );
                } else if (i == 2) {
                  // تحديد السلوك عند النقر على هذا النص
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FamilyRecord(),
                    ),
                  );
                } else if (i == 3) {
                  // تحديد السلوك عند النقر على هذا النص
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullCheckScreen(),
                    ),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                // padding: EdgeInsets.only(bottom: 10),
                margin: EdgeInsets.only(bottom: 10, left: 8, right: 8),
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff28CC9E),
                    width: 2.0,
                  ),
                  color: Colors.white,
                  // borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            cateogry[i],
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff28CC9E)),
                            // textAlign: TextAlign.center,
                            //overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              shohoreNames[i],
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff475268)),
                              // textAlign: TextAlign.center,
                              //overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color(0xff28CC9E),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 25,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/Images/image$i.png',
                      height: 160,
                      width: 160,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
