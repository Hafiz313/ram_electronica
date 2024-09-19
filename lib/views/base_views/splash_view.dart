
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/utils/app_constands.dart';

import '../../consts/assets.dart';
import '../../consts/colors.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../main.dart';
import '../auth/login_view.dart';
import '../intro/intro_view.dart';
import 'mainView.dart';

class SplashView extends StatefulWidget {
  static const String routeName = '/splash_view';

  const SplashView({Key? key}) : super(key: key);

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> with SingleTickerProviderStateMixin  {
  late AnimationController _controller;
  late Animation<double> _animation;
  final box=GetStorage();
  @override
  void initState() {
    super.initState();
    _init();

  }

  Future<void> _init() async {

    // navigate.currentState?.pushNamed(IntroView.routeName);
    // if (context.mounted) {
    // final read = context.read<AuthViewModel>();
    // final isAuth = await read.checkAuth();
    // if (isAuth) {
    //   // navigate.currentState?.pushNamed(HomeView.routeName);
    // } else {
    //   navigate.currentState?.pushNamed(LoginView.routeName);
    // }
    // // }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _controller.forward();

    Timer(const Duration(seconds: 3), () {

      debugPrint("====kIntroCheck: ${box.hasData(kIntroCheck)}=========");
      box.hasData(kIntroCheck) ?
     navigate.currentState?.pushNamed(LoginView.routeName):
     navigate.currentState?.pushNamed(IntroView.routeName);



    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: FadeTransition(
            opacity: _animation,
            child: Image.asset(AppAssets.logo)),
      ),
    );
  }
}
