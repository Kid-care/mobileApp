import 'package:flutter/material.dart';
import 'package:healthcare/user/Views/chronic_diseases_user.dart';
import 'package:healthcare/user/Views/medical_diagnoses_user.dart';
import 'package:healthcare/user/Views/surgeries_user.dart';

class ItemOfDiseas extends StatelessWidget {
  const ItemOfDiseas({super.key});

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
                      builder: (context) => ChronicDiseaseUser(),
                    ),
                  );
                } else if (i == 1) {
                  // تحديد السلوك عند النقر على هذا النص
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MedicalDiagnosesUser(),
                    ),
                  );
                } else if (i == 2) {
                  // تحديد السلوك عند النقر على هذا النص
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SurgeriesUser(),
                    ),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                // padding: EdgeInsets.only(bottom: 10),
                margin: const EdgeInsets.only(bottom: 10, left: 8, right: 8),
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xff28CC9E),
                    width: 2.0,
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            height: 7,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              shohoreNames[i],
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff475268)),
                              softWrap: true,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Row(
                              children: [
                                Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff28CC9E),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      size: 25,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
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
