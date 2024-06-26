import 'package:flutter/material.dart';
import 'package:healthcare/share/colors.dart';
import 'package:healthcare/user/Views/register_screen.dart';
import 'package:healthcare/user/shared/text_field.dart';

class RegisterTwo extends StatefulWidget {
  final String name;
  final String email;
  final String phone;

  RegisterTwo({
    required this.email,
    required this.phone,
    required this.name,
  });

  @override
  State<RegisterTwo> createState() => _RegisterTwoState();
}

class _RegisterTwoState extends State<RegisterTwo> {
  bool obscurePassword = true;
  final TextEditingController nationalIdController = TextEditingController();
  final TextEditingController motherNameController = TextEditingController();
  final TextEditingController fatherNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                          icon: Icon(
                            Icons.arrow_back,
                            size: 30,
                          )),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Image.asset(
                  height: MediaQuery.of(context).size.height * 0.33,
                  width: MediaQuery.of(context).size.width,
                  "assets/Images/sign2.png",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: const Text(
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
                      height: 22,
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
                      height: 22,
                    ),
                    TextFormShare(
                      controllerr: passwordController,
                      textvalidator: (input) {
                        if (passwordController.text.isEmpty) {
                          return ("من فضلك ادخل كلمة اسر");
                        } else if (passwordController.text.length < 6) {
                          return "الرقم السري يجب ان يكون اكثر من 6 ارقام";
                        }
                        return null;
                      },
                      textkeytype: TextInputType.visiblePassword,
                      labelname: "الرقم السري",
                      suffixIcon: obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      obscureText: obscurePassword,
                      suffixAction: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 22,
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
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000).withOpacity(0.25),
                              spreadRadius: 0,
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterScreen(
                                    name: widget.name,
                                    email: widget.email,
                                    phone: widget.phone,
                                    fatherName: fatherNameController.text,
                                    motherName: motherNameController.text,
                                    password: passwordController.text,
                                    nationalId: nationalIdController.text,
                                  ),
                                ),
                              );
                            }
                          },
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'التالى',
                              style: TextStyle(
                                color: Color(0xff132F2B),
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
