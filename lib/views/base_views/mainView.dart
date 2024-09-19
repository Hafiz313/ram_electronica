import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../consts/assets.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../core/viewmodels/home_viewmodel.dart';
import '../HomeView/home_view.dart';
import '../attendance/attendance_view.dart';
import '../auth/forget_view.dart';
import '../auth/login_view.dart';
import '../profile/profile_view.dart';

class MainView extends StatefulWidget {


  const MainView({Key? key}) : super(key: key);
  static const String routeName = '/MainView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeView(),
    const AttendanceView(),
     const ProfileView()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final read = context.read<HomeViewModel>();
    return
        SafeArea(
          child: Scaffold(
            backgroundColor: AppColors.primary,
              resizeToAvoidBottomInset: true,
              bottomNavigationBar:BottomNavigationBar(
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAssets.home,
                      color: _selectedIndex == 0 ? AppColors.primaryDark :AppColors.textColor,
                    ),
                    label: Lang.home,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                     AppAssets.attendance,
                      color: _selectedIndex == 1 ?AppColors.primaryDark :AppColors.textColor,
                    ),
                    label: Lang.attendance,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                     AppAssets.profile,
                      color: _selectedIndex == 2 ? AppColors.primaryDark :AppColors.textColor,
                    ),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: AppColors.primaryDark,
                onTap: _onItemTapped,
              ),
              body: _screens[_selectedIndex],),
        );
  }





}
