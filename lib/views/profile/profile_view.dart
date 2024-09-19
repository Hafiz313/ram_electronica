import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/utils/app_constands.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import 'package:ram_elettronica/views/profile/my_profile_view.dart';

import '../../consts/assets.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../core/viewmodels/home_viewmodel.dart';
import '../../main.dart';
import '../auth/login_view.dart';
import '../base_views/base_scaffold.dart';
import '../widget/text.dart';
import 'change_Language_view.dart';
import 'change_password_view.dart';
import 'disput_view.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child:  BaseScaffold(
          showBackButton:false,
          body: Container(
            color: AppColors.darkBlue,
            child: Column(
              children: [
                SizedBox(height: context.percentWidth * 10,),
                Container(
                    alignment: Alignment.center,
                    child: Image.asset(AppAssets.avatar)),
                SizedBox(height: context.percentWidth * 2,),
                subText5('${GetStorage().read(kName)}',color: AppColors.white),
                SizedBox(height: context.percentWidth * 1,),
                subText5('${GetStorage().read(kEmailID)}',color: AppColors.white,fontWeight: FontWeight.w300),
                SizedBox(height: context.percentWidth * 8,),
                Expanded(
                  child: Material(
                    elevation: 10,
                    color: AppColors.white,
                    shape:  const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),

                    child: Column(
                      children: [
                        SizedBox(height: context.percentHeight * 3,),
                        Container(
                          color: AppColors.bgGrayColor,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(vertical: context.percentWidth * 2,horizontal: context.percentWidth * 4),
                          child: subText5(Lang.account,color: AppColors.blackColor),
                        ),
                        SizedBox(height: context.percentHeight * 2,),
                        profileIcon(context,title: Lang.myProfile,img: AppAssets.profileIcon,onTap: ()=>
                            navigate.currentState?.pushNamed(MyProfileView.routeName)),
                        profileIcon(context,title: Lang.changePassword,img: AppAssets.changPasswordIcon,onTap: ()=>
                          navigate.currentState?.pushNamed(ChangePasswordView.routeName
                        )),
                        Container(
                          color: AppColors.bgGrayColor,
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(vertical: context.percentWidth * 2,horizontal: context.percentWidth * 4),
                          child: subText5(Lang.action,color: AppColors.blackColor),
                        ),
                        profileIcon(context,title: Lang.language,img: AppAssets.languageIcon,onTap: ()=>
                            navigate.currentState?.pushNamed(ChangeLanguageView.routeName)),
                        profileIcon(context,title: Lang.dispute,img: AppAssets.questionMark,onTap: ()=>
                            navigate.currentState?.pushNamed(DisputeView.routeName)),
                        profileIcon(context,title: Lang.logOut,img: AppAssets.logoutIcon,onTap: (){

                          _showLogoutDialog(context);
                        }),

                      ],
                    ),
                  ),
                )


              ],
            ),
          )
      ),
    );
  }

  void _logoutAndNavigateToLogin(BuildContext context) {
    Navigator.pushReplacementNamed(context,LoginView.routeName,); // Assuming '/login' is your login route
  }

  // Function to show the logout dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to log out?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<AuthViewModel>().logOut(

                    callBack: (isSuccess) {
                      if (isSuccess) {

                        Navigator.of(context).pop();
                        _logoutAndNavigateToLogin(context);
                      }
                    }
                );
                // Navigator.of(context).pop(); // Close the dialog
                // Add your logout logic here (e.g., clearing session, navigating to login page, etc.)
                print('User logged out');
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  Widget profileIcon(BuildContext context ,{required String title,required String img, required GestureTapCallback onTap}){
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 3),
        margin: EdgeInsets.symmetric(vertical: context.percentHeight * 1),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(img),
                    SizedBox(width: context.percentWidth * 2,),
                    subText5(title)
                  ],
                ),
                const Icon(FontAwesomeIcons.angleRight,color: AppColors.textColor,size: 15,)
              ],
            ),
            SizedBox(height: context.percentHeight * 1,),
            Container(margin: EdgeInsets.symmetric(vertical: context.percentWidth * 2,horizontal: context.percentWidth * 3),height: 0.7,width: double.infinity,color: AppColors.textColor,)
          ],
        ),
      ),
    );
  }

}
