import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/admin/Models/user_model.dart';
import 'package:healthcare/user/Services/profile_cubit.dart';
import 'package:healthcare/user/Services/profile_states.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:healthcare/user/shared/text_field.dart';
import 'package:intl/intl.dart';

class UpdateUserDataScreen extends StatefulWidget {
  const UpdateUserDataScreen({Key? key}) : super(key: key);

  @override
  _UpdateUserDataScreenState createState() => _UpdateUserDataScreenState();
}

class _UpdateUserDataScreenState extends State<UpdateUserDataScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController bloodTypeController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  List<String> bloodTypes = ['O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'];
  String selectedBloodType = '';

  @override
  void initState() {
    super.initState();
    final cubit = BlocProvider.of<ProfileCubit>(context);
    updateTextControllers(cubit.userModel);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final cubit = BlocProvider.of<ProfileCubit>(context);
    updateTextControllers(cubit.userModel);
  }

  void updateTextControllers(UserModel? userModel) {
    nameController.text = userModel?.userName ?? '';
    phoneController.text = userModel?.phoneNumber ?? '';
    fatherNameController.text = userModel?.fatherName ?? '';
    motherNameController.text = userModel?.motherName ?? '';
    nationalIdController.text = userModel?.NationalID ?? '';
    selectedBloodType = userModel?.bloodType ?? '';
    if (userModel?.birthDate != null) {
      final DateFormat serverFormat = DateFormat('yyyy/MM/dd');
      final DateTime birthDate = serverFormat.parse(userModel!.birthDate!);
      dayController.text = birthDate.day.toString();
      monthController.text = birthDate.month.toString();
      yearController.text = birthDate.year.toString();
    }
  }

  String convertBloodType(String bloodType) {
    if (bloodType.length == 2) {
      return '${bloodType[1]}${bloodType[0]}';
    } else if (bloodType.length == 3) {
      return '${bloodType[2]}${bloodType[0]}${bloodType[1]}';
    } else {
      return bloodType;
    }
  }

  // String selectedBlood = cubit.userModel!.bloodType!;
  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ProfileCubit>(context);
    return Scaffold(
      appBar: AppBar(
        // title: const Text("تعديل البيانات"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      endDrawer: CustomEndDrawer(),
      body: ListView(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xffB4B4B4),
            radius: 70,
            child: Icon(
              Icons.person,
              color: Colors.white,
              size: 120,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormShare(
            controllerr: nameController,
            textvalidator: (input) {
              return null;
            },
            textkeytype: TextInputType.name,
            labelname: "اسم المستخدم",
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormShare(
            controllerr: phoneController,
            textvalidator: (input) {
              if (phoneController.text.isEmpty) {
                return ("من فضلك ادخل رقم الموبايل");
              } else if (phoneController.text.length != 11) {
                return "الرقم الموبايل يجب ان يكون 11 رقم";
              } else {
                return null;
              }
            },
            textkeytype: TextInputType.number,
            labelname: "رقم الهاتف",
            //  textname: "Phone",
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormShare(
            controllerr: fatherNameController,
            textvalidator: (input) {
              if (fatherNameController.text.isEmpty) {
                return ("من فضلك ادخل اسم الاب");
              } else if (fatherNameController.text.length < 2) {
                return "يجب ان يكون اسم الاب اكثر من 1 حروف";
              }
              return null;
            },
            textkeytype: TextInputType.name,
            labelname: "اسم الاب",
            // textname: "Email",
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormShare(
            controllerr: motherNameController,
            textvalidator: (input) {
              if (motherNameController.text.isEmpty) {
                return ("من فضلك ادخل اسم الام");
              } else if (motherNameController.text.length < 3) {
                return "يجب ان يكون اسم الام اكثر من 3 حروف";
              }
              return null;
            },
            textkeytype: TextInputType.name,
            labelname: "اسم الام",
            // textname: "Email",
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormShare(
            controllerr: nationalIdController,
            textvalidator: (value) {
              if (nationalIdController.text.isEmpty) {
                return ("من فضلك ادخل الرقم القومى");
              } else if (nationalIdController.text.length != 14) {
                return "الرقم القومى يجب ان يكون 14 رقم";
              }
              return null;
            },
            textkeytype: TextInputType.number,
            labelname: "الرقم القومى",
            //  textname: "Phone",
          ),
          const SizedBox(
            height: 20,
          ),
          // TextField(
          //   controller: passwordController,
          //   //  readOnly: true,
          //   decoration: InputDecoration(
          //       border: OutlineInputBorder(), labelText: " كلمة السر"),
          // ),
          // SizedBox(
          //   height: 15,
          // ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: Text(
                  "تاريخ الميلاد",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 17,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Day TextField
                SizedBox(
                  width: 80.0,
                  child: TextFormField(
                    controller: dayController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("ادخل اليوم");
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'اليوم',
                      labelStyle: const TextStyle(
                          backgroundColor: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 14.0, horizontal: 13.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff28CC9E)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xff28CC9E),
                          )),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                // Month TextField
                SizedBox(
                  width: 80.0,
                  child: TextFormField(
                    controller: monthController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("ادخل الشهر");
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'الشهر',
                      labelStyle: const TextStyle(
                          backgroundColor: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 13.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff28CC9E)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: Color(0xff28CC9E),
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                // Year TextField
                SizedBox(
                  width: 80.0,
                  child: TextFormField(
                    controller: yearController,
                    enabled: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("ادخل السنه");
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'السنة',
                      labelStyle: const TextStyle(
                          backgroundColor: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 13.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Color(0xff28CC9E)),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xff28CC9E),
                          )),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const SizedBox(width: 16),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Text(
              'فصيلة الدم ',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 25),
            child: Row(
              children: [
                DropdownButton<String>(
                  underline: Container(
                    padding: const EdgeInsets.only(
                        top: 20), // تباعد الـ underline عن الزر من الأعلى
                    height: 2, // ارتفاع خط السفلي
                    color: const Color(0xff28cc9e), // لون خط السفلي
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  value: selectedBloodType,
                  onChanged: (newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedBloodType = newValue;
                      });
                    }
                  },
                  items: bloodTypes.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Center(
                        child: Text(convertBloodType(value)),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<ProfileCubit, ProfileState>(
            listener: (context, state) {
              if (state is UpdateUserDataSuccessState) {
                showSnackBarItem(context, "تم تعديل البيانات بنجاح", true);
                Navigator.pop(context);
              }
              if (state is UpdateUserDataWithFailureState) {
                showSnackBarItem(context, state.error, false);
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(
                    right: 60, left: 60, top: 12, bottom: 18),
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff28CC9E),
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff000000).withOpacity(0.25),
                        spreadRadius: 1,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (nameController.text.isNotEmpty &&
                          phoneController.text.isNotEmpty &&
                          yearController.text.isNotEmpty &&
                          monthController.text.isNotEmpty &&
                          dayController.text.isNotEmpty &&
                          selectedBloodType.isNotEmpty &&
                          fatherNameController.text.isNotEmpty &&
                          motherNameController.text.isNotEmpty &&
                          nationalIdController.text.isNotEmpty) {
                        cubit.updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          fatherName: fatherNameController.text,
                          motherName: motherNameController.text,
                          nationalId: nationalIdController.text,
                          bloodType: selectedBloodType,
                          // تجميع تاريخ الميلاد
                          date:
                              '${yearController.text}/${monthController.text}/${dayController.text}',
                        );
                        // }
                      }
                    },
                    textColor: const Color(0xff000000),
                    child: Text(
                      state is UpdateUserDataLoadingState ? "انتظر..." : "حفظ",
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void showSnackBarItem(
      BuildContext context, String message, bool forSuccessOrFailure) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,
      behavior: SnackBarBehavior.floating,
    ));
  }
}
