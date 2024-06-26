import 'package:flutter/material.dart';
import 'package:healthcare/admin/Views/chronic_disese_admin.dart';
import 'package:healthcare/admin/Views/medical_diagnoses_admin.dart';
import 'package:healthcare/admin/Views/surgeries_admin.dart';

class ItemOfDiseasAdmin extends StatelessWidget {
  const ItemOfDiseasAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> shohoreNames = [
      "الامراض المزمنه",
      "التشخيصات الطبيه",
      "العمليات الجراحيه",
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          for (int i = 0; i < 3; i++)
            GestureDetector(
              onTap: () {
                if (i == 0) {
                  // تحديد السلوك عند النقر على هذا النص
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChronicDisease(),
                    ),
                  );
                } else if (i == 1) {
                  // تحديد السلوك عند النقر على هذا النص
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicalDiagnoses(),
                    ),
                  );
                } else if (i == 2) {
                  // تحديد السلوك عند النقر على هذا النص
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Surgeries(),
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
                      'assets/Images/images$i.png',
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
