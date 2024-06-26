import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/admin/Views/user_login.dart';
import 'package:healthcare/user/Services/auth_cubit.dart';
import 'package:healthcare/user/Services/auth_states.dart';
import 'package:healthcare/user/Views/home_screen.dart';
import 'package:healthcare/user/Views/register_one.dart';
import 'package:healthcare/user/Views/reset_password.dart';
import 'package:healthcare/user/shared/alert_dialog.dart';
import 'package:healthcare/user/shared/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscurePassword = true;
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xffFFFFFF),
        ),
        child: BlocConsumer<AuthCubit, AuthStates>(
          listener: (context, state) {
            if (state is FailedToLoginState) {
              showAlertDialog(
                  context: context,
                  backgroundColor: Colors.white,
                  content: Text(
                    state.message,
                    textDirection: TextDirection.rtl,
                  ));
            } else if (state is LoginSuccessState) {
              saveAccount(emailController.text);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()));
            } else if (state is AdminLoginSuccessState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserLoginScreen()));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 90,
                  ),
                  Image.asset("assets/Images/login (2).png"),
                  const SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 30, left: 30),
                              child: Text(
                                "تسجيل الدخول",
                                style: TextStyle(
                                    color: Color(0xff132F2B),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
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
                          controllerr: passwordController,
                          textvalidator: (value) {
                            if (passwordController.text.isEmpty) {
                              return ("من فضلك ادخل كلمة السر");
                            } else if (passwordController.text.length < 6) {
                              return ("كلمة السر يجب ان تحتوى على اكثر من 5 ارقام");
                            } else {
                              return null;
                            }
                          },
                          textkeytype: TextInputType.visiblePassword,
                          // textname: " الرقم السري",
                          labelname: " الرقم السري",
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
                          height: 4,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 30, left: 30),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ResetPasswordPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "نسيت الرقم السري ؟",
                                    style: TextStyle(
                                        color: const Color(0xff132F2B)
                                            .withOpacity(0.7),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xff196B69),
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
                                      authCubit.login(
                                        email: emailController.text,
                                        password: passwordController.text,
                                      );
                                    }
                                  },
                                  textColor: const Color(0xffFFFFFF),
                                  child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        state is LoginLoadingState
                                            ? "انتظر..."
                                            : "تسجيل الدخول",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18),
                                      )),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RegisterOne(),
                                      ),
                                    );
                                  },
                                  textColor: const Color(0xff132F2B),
                                  child: const FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text('انشاء حساب',
                                          style: TextStyle(
                                            color: Color(0xff132F2B),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                          ))),
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

  void saveAccount(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
  }
}
