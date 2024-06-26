import 'package:flutter/material.dart';
import 'package:healthcare/share/colors.dart';
import 'package:healthcare/user/Views/login_screen.dart';
import 'package:healthcare/user/Views/register_two.dart';
import 'package:healthcare/user/shared/text_field.dart';

class RegisterOne extends StatefulWidget {
  RegisterOne({super.key});

  @override
  State<RegisterOne> createState() => _RegisterOneState();
}

class _RegisterOneState extends State<RegisterOne> {
  final phoneController = TextEditingController();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

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
                // child: Container(
                //     alignment: Alignment.centerLeft,
                //     width: MediaQuery.of(context).size.width,
                //     height: 100,
                //     child: Image.asset("assets/Images/logo.png")),
              ),
              Image.asset(
                height: MediaQuery.of(context).size.height * 0.33,
                width: MediaQuery.of(context).size.width,
                "assets/Images/sign1.png",
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
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
                        height: 7,
                      ),
                      TextFormShare(
                        controllerr: nameController,
                        textvalidator: (input) {
                          if (nameController.text.isEmpty) {
                            return ("من فضلك ادخل الاسم");
                          } else if (nameController.text.length < 5) {
                            return "يجب ان يكون الاسم اكثر من 4 حروف";
                          } else {
                            return null;
                          }
                        },
                        textkeytype: TextInputType.name,
                        labelname: "اسم المستخدم",
                        // textname: "Username",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormShare(
                        controllerr: emailController,
                        textvalidator: (input) {
                          if (emailController.text.isEmpty) {
                            return ("من فضلك ادخل الايميل");
                          } else if (!emailController.text.contains("@") &&
                              !emailController.text.contains(".")) {
                            return "يجب ان يحتوى الايميل على \"@\" and \".\"";
                          } else {
                            return null;
                          }
                        },
                        textkeytype: TextInputType.emailAddress,
                        labelname: "البريد الالكترونى",
                        // textname: "Email",
                      ),
                      const SizedBox(
                        height: 15,
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
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff000000).withOpacity(0.25),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (formKey.currentState!.validate() ==
                                      true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterTwo(
                                          name: nameController.text,
                                          email: emailController.text,
                                          phone: phoneController.text,
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
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xff196B69),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xff000000).withOpacity(0.25),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: MaterialButton(
                                elevation: 0,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(),
                                    ),
                                  );
                                },
                                textColor: Color(0xffFFFFFF),
                                child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "تسجيل دخول",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
