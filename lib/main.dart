import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healthcare/admin/Services/profile_user_cubit.dart';
import 'package:healthcare/admin/Services/user_cubit.dart';
import 'package:healthcare/admin/Views/user_login.dart';
import 'package:healthcare/share/bloc_observer.dart';
import 'package:healthcare/share/constant.dart';
import 'package:healthcare/share/local_network.dart';
import 'package:healthcare/user/Services/auth_cubit.dart';
import 'package:healthcare/user/Services/profile_cubit.dart';
import 'package:healthcare/user/Views/home_screen.dart';
import 'package:healthcare/user/Views/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheNetwork.cacheInitialization();
  userToken = await CacheNetwork.getCacheData(key: 'token');
  userId = await CacheNetwork.getCacheData(key: 'id');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<ProfileCubit>(create: (context) => ProfileCubit()),
        BlocProvider<ProfileUserCubit>(create: (context) => ProfileUserCubit()),
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          theme: ThemeData(primarySwatch: Colors.grey),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('ar'),
            Locale('AE'),
          ],
          // home: userToken != null ? const HomeScreen() : SplashScreen()),
          home: (adminToken != null)
              ? UserLoginScreen()
              : (userToken != null)
                  ? const HomeScreen()
                  : const SplashScreen(),
          // designSize: const Size(392.7, 872.7),
        ),
      ),
    );
  }
}
