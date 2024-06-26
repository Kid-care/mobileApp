import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/share/colors.dart';
import 'package:healthcare/user/Services/auth_cubit.dart';
import 'package:healthcare/user/Services/auth_states.dart';
import 'package:healthcare/user/Views/login_screen.dart';
import 'package:healthcare/user/shared/alert_dialog.dart';
import 'package:healthcare/user/shared/fasylat_dam.dart';

class RegisterScreen extends StatefulWidget {
  final String fatherName;
  final String motherName;
  final String password;
  final String nationalId;
  final String name;
  final String email;
  final String phone;

  RegisterScreen({
    required this.fatherName,
    required this.motherName,
    required this.name,
    required this.email,
    required this.password,
    required this.nationalId,
    required this.phone,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController fatherNameController;
  late TextEditingController motherNameController;
  late TextEditingController passwordController;
  late TextEditingController nationalIdController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController nameController;
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedBlood = '';
  @override
  void initState() {
    super.initState();
    fatherNameController = TextEditingController(text: widget.fatherName);
    motherNameController = TextEditingController(text: widget.motherName);
    passwordController = TextEditingController(text: widget.password);
    nationalIdController = TextEditingController(text: widget.nationalId);
    emailController = TextEditingController(text: widget.email);
    phoneController = TextEditingController(text: widget.phone);
    nameController = TextEditingController(text: widget.name);
    // يمكنك تهيئة المتغيرات الإضافية هنا إن كانت مطلوبة
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is FailedToRegisterState) {
          showAlertDialog(
              context: context,
              backgroundColor: Colors.white,
              content: Text(
                state.message,
                textDirection: TextDirection.rtl,
              ));
        } else if (state is RegisterSuccessState) {
          showAlertDialog(
              context: context,
              backgroundColor: Colors.red,
              content: const Text("تم تسجيل الحساب بنجاح"));
          Navigator.pop(context); // عشان يخرج من alertDialog
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10, left: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 30,
                              )),
                        ],
                      ),
                    ),
                  ),
                  Image.asset(
                    height: MediaQuery.of(context).size.height * 0.33,
                    width: MediaQuery.of(context).size.width,
                    "assets/Images/sign3.png",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 30, left: 30),
                              child: Text(
                                "انشاء حساب",
                                style: TextStyle(
                                    color: Color(0xff132F2B),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: Text(
                                "تاريخ الميلاد",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000)),
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
                                      borderSide: const BorderSide(
                                          color: Color(0xff28CC9E)),
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
                                      borderSide: const BorderSide(
                                          color: Color(0xff28CC9E)),
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
                              SizedBox(
                                width: 80.0,
                                child: TextFormField(
                                  controller: yearController,
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
                                      borderSide: const BorderSide(
                                          color: Color(0xff28CC9E)),
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
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: Text(
                                "فصيلة الدم",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff000000)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        App(
                          onBloodTypeSelected: (selectedBloodType) {
                            selectedBlood = selectedBloodType;
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      const Color(0xff000000).withOpacity(0.25),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: MaterialButton(
                              elevation: 0,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  String formattedDate =
                                      '${yearController.text}/${monthController.text}/${dayController.text}';
                                  BlocProvider.of<AuthCubit>(context).register(
                                    email: emailController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    nationalId: nationalIdController.text,
                                    fatherName: fatherNameController.text,
                                    motherName: motherNameController.text,
                                    date: formattedDate,
                                    bloodType: selectedBlood.toString(),
                                  );
                                }
                              },
                              textColor: const Color(0xff000000),
                              child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(
                                    state is RegisterLoadingState
                                        ? "انتظر..."
                                        : "انشاء حساب",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18),
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
