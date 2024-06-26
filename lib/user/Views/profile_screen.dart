import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/user/Services/auth_states.dart';
import 'package:healthcare/user/Services/profile_cubit.dart';
import 'package:healthcare/user/Services/profile_states.dart';
import 'package:healthcare/user/Views/login_screen.dart';
import 'package:healthcare/user/Views/update_user_screen.dart';
import 'package:healthcare/user/shared/end_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  // get authProvider => null;
  void signOutUser(BuildContext context, SharedPreferences prefs) async {
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          // Call getUserData after successful login
          context.read<ProfileCubit>().getUserData();
        }
      },
      builder: (context, state) {
        final cubit = BlocProvider.of<ProfileCubit>(context);
        if (cubit.userModel == null) cubit.getUserData();
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              elevation: 0,
              backgroundColor: Colors.white,
              title: GestureDetector(
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      'تعديل',
                      style: TextStyle(fontSize: 17),
                    ),
                    //SizedBox(width: 2),
                    Image.asset(
                      'assets/Images/tabler_edit.png',
                      width: 30,
                    ) // مسافة بين الصورة والنص
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdateUserDataScreen(),
                    ),
                  );
                },
              ),
            ),
            endDrawer: CustomEndDrawer(),
            body: cubit.userModel != null
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 19, left: 17),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          Text(
                            "الاسم",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            cubit.userModel?.userName ?? "",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Divider(
                            color: const Color(0xff28CC9E).withOpacity(0.4),
                            thickness: 2,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "البريد الالكترونى",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            cubit.userModel?.email ?? "",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Divider(
                            color: const Color(0xff28CC9E).withOpacity(0.4),
                            thickness: 2,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "اسم الاب",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            cubit.userModel?.fatherName ?? "",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Divider(
                            color: const Color(0xff28CC9E).withOpacity(0.4),
                            thickness: 2,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "اسم الام",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            cubit.userModel?.motherName ?? "",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Divider(
                            color: const Color(0xff28CC9E).withOpacity(0.4),
                            thickness: 2,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "الرقم القومي",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            cubit.userModel?.NationalID ?? "",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Divider(
                            color: const Color(0xff28CC9E).withOpacity(0.4),
                            thickness: 2,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "رقم الهاتف",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            cubit.userModel?.phoneNumber ?? "",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Divider(
                            color: const Color(0xff28CC9E).withOpacity(0.4),
                            thickness: 2,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "تاريخ الميلاد",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            cubit.userModel?.birthDate ?? "",
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          Divider(
                            color: const Color(0xff28CC9E).withOpacity(0.4),
                            thickness: 2,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "فصيلة الدم",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            convertBloodType(cubit.userModel?.bloodType ?? ""),
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ));
      },
    );
  }
}
