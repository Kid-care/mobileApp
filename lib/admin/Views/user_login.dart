import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/admin/Services/user_cubit.dart';
import 'package:healthcare/admin/Services/user_state.dart';
import 'package:healthcare/admin/Views/admin_category.dart';
import 'package:healthcare/user/shared/alert_dialog.dart';
import 'package:healthcare/user/shared/text_field.dart';

class UserLoginScreen extends StatefulWidget {
  UserLoginScreen({Key? key}) : super(key: key);

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  // bool obscurePassword = true;
  final emailController = TextEditingController();

  //final idController = TextEditingController();
  final idController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //final UserCubit authCubit = BlocProvider.of<UserCubit>(context);
    final UserCubit userCubit = BlocProvider.of<UserCubit>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffFFFFFF),
        ),
        child: BlocConsumer<UserCubit, UserStates>(
          listener: (context, state) {
            if (state is UserFailedToLoginState) {
              showAlertDialog(
                  context: context,
                  backgroundColor: Colors.white,
                  content: Text(
                    state.message,
                    textDirection: TextDirection.rtl,
                  ));
            } else if (state is UserLoginSuccessState) {
              //saveAccount(emailController.text);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeAdminScreen()));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Image.asset("assets/Images/Doctor-rafiki 1 (1).png"),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormShare(
                          controllerr: emailController,
                          textvalidator: (value) {
                            if (emailController.text.isEmpty) {
                              return ("من فضلك ادخل الايميل");
                            } else if (emailController.text.contains("@") &&
                                !emailController.text.contains(".")) {
                              return "يجب ان يحتوى الايميل على \"@\" and \".\"";
                            }
                            return null;
                          },
                          textkeytype: TextInputType.emailAddress,
                          // textname: "رقم الهاتف",
                          labelname: "البريد الالكترونى",
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        TextFormShare(
                          controllerr: idController,
                          textvalidator: (value) {
                            if (idController.text.isEmpty) {
                              return ("من فضلك ادخل الرقم القومى");
                            } else if (idController.text.length != 14) {
                              return ("الرقم القومى يجب ان يحتوي على 14 رقم");
                            } else {
                              return null;
                            }
                          },
                          // textkeytype: TextInputType.visiblePassword,
                          // textname: " الرقم السري",
                          labelname: " الرقم القومى",
                          // suffixIcon: obscurePassword
                          //     ? Icons.visibility
                          //     : Icons.visibility_off,
                          // obscureText: obscurePassword,
                          // suffixAction: () {
                          //   setState(() {
                          //     obscurePassword = !obscurePassword;
                          //   });
                          // },
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff28CC9E),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xff000000)
                                          .withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                                child: MaterialButton(
                                  elevation: 0,
                                  onPressed: () {
                                    if (formKey.currentState!.validate() ==
                                        true) {
                                      userCubit.search(
                                        email: emailController.text,
                                        id: idController.text,
                                      );
                                    }
                                  },
                                  textColor: const Color(0xff000000),
                                  child: const FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "التالي",
                                        // state is UserLoginLoadingState
                                        //     ? "انتظر..."
                                        //     : "التالي",
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
