import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/user/Services/reset_password_cubit.dart';
import 'package:healthcare/user/Services/reset_password_state.dart';
import 'package:healthcare/user/Views/login_screen.dart';
import 'package:healthcare/user/shared/text_field.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ResetPasswordCubit(),
        child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) async {
            if (state is ResetEmailSent) {
              await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Image.asset("assets/Images/email.png"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Center(
                            child: Text(
                          'OK',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red),
                        )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              );
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            } else if (state is ResetEmailError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
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
                            // Image.asset("assets/Images/logo.png",width: 80,height: 80,),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Image.asset("assets/Images/reset.png"),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Row(
                        children: [
                          Text(
                            "ادخل البريد الالكترونى",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff132F2B)),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
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
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(right: 30, left: 30),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Color(0xff28CC9E),
                          borderRadius: BorderRadius.circular(10),
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
                            if (formKey.currentState!.validate() == true) {
                              final email = emailController.text;
                              context
                                  .read<ResetPasswordCubit>()
                                  .sendResetEmail(email);
                            }
                          },
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              'التالى',
                              style: TextStyle(
                                color: Color(0xff000000),
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
            );
          },
        ),
      ),
    );
  }
}
