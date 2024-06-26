import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/admin/Services/profile_user_cubit.dart';
import 'package:healthcare/admin/Services/profile_user_state.dart';
import 'package:healthcare/admin/Views/admin_category.dart';
import 'package:healthcare/admin/shared/admin_enddrawer.dart';

class ProfileAdminScreen extends StatefulWidget {
  const ProfileAdminScreen({Key? key}) : super(key: key);

  @override
  State<ProfileAdminScreen> createState() => _ProfileAdminScreenState();
}

class _ProfileAdminScreenState extends State<ProfileAdminScreen> {
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
    return BlocConsumer<ProfileUserCubit, ProfileUserState>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = BlocProvider.of<ProfileUserCubit>(context);
        if (cubit.userModel == null) cubit.getUsersData();
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeAdminScreen(),
                    ),
                  ); // الانتقال إلى الصفحة السابقة عند الضغط على الزر
                },
              ),
            ),
            endDrawer: AdminEndDrawer(),
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
