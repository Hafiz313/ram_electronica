import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/views/HomeView/home_view.dart';
import 'package:ram_elettronica/views/HomeView/location_view.dart';
import 'package:ram_elettronica/views/auth/forget_view.dart';
import 'package:ram_elettronica/views/auth/login_view.dart';
import 'package:ram_elettronica/views/auth/otp_view.dart';
import 'package:ram_elettronica/views/auth/password_update_view.dart';
import 'package:ram_elettronica/views/auth/reset_password_view.dart';
import 'package:ram_elettronica/views/base_views/mainView.dart';
import 'package:ram_elettronica/views/base_views/splash_view.dart';
import 'package:ram_elettronica/views/intro/intro_view.dart';
import 'package:ram_elettronica/views/profile/change_Language_view.dart';
import 'package:ram_elettronica/views/profile/change_password_view.dart';
import 'package:ram_elettronica/views/profile/disput_view.dart';
import 'package:ram_elettronica/views/profile/my_profile_view.dart';
import 'package:ram_elettronica/views/profile/password_change_view.dart';
import 'package:ram_elettronica/views/profile/submit_view.dart';

import 'consts/colors.dart';
import 'consts/lang.dart';
import 'core/viewmodels/auth_viewmodel.dart';
import 'core/viewmodels/home_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthViewModel>(create: (_) => AuthViewModel()),
          ChangeNotifierProvider<HomeViewModel>(create: (_) => HomeViewModel()),
        ],
        child: Consumer(builder: (context, notifier, child) {
          return MaterialApp(
            title: Lang.ramElettronica,
            debugShowCheckedModeBanner: false,
            color: AppColors.white,
            navigatorKey: navigate,
            initialRoute: SplashView.routeName,
            builder: EasyLoading.init(),
            routes: {
              SplashView.routeName: (context) => const SplashView(),
              LoginView.routeName: (context) => LoginView(),
              IntroView.routeName: (context) => IntroView(),
              ForgetView.routeName: (context) => ForgetView(),
              OtpView.routeName: (context) => const OtpView(),
              ResetPasswordView.routeName: (context) =>  ResetPasswordView(),
              PasswordUpdateView.routeName: (context) =>  const PasswordUpdateView(),
              HomeView.routeName: (context) =>  const HomeView(),
              LocationView.routeName: (context) =>  const LocationView(),
              MainView.routeName: (context) =>  const MainView(),
              MyProfileView.routeName: (context) =>   MyProfileView(),
              MyProfileView.routeName: (context) =>   MyProfileView(),
              ChangePasswordView.routeName: (context) =>   ChangePasswordView(),
              PasswordChangeView.routeName: (context) =>   const PasswordChangeView(),
              ChangeLanguageView.routeName: (context) =>    ChangeLanguageView(),
              SubmitView.routeName: (context) =>    const SubmitView(),
              DisputeView.routeName: (context) =>     DisputeView(),
            },
          );
        }));
  }
}


//Global key for context
GlobalKey<NavigatorState> navigate = GlobalKey<NavigatorState>();
