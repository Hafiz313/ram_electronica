
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/widgets.dart'; // Ensure you import the necessary packages
import 'package:provider/provider.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import 'package:ram_elettronica/views/auth/login_view.dart';
import 'package:ram_elettronica/views/base_views/base_scaffold.dart';
import 'package:ram_elettronica/views/base_views/base_scaffold_auth.dart';
import '../../consts/assets.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../main.dart';
import '../base_views/mainView.dart';
import '../widget/text_button.dart';
import '../widget/buttons.dart';
import '../widget/text.dart';
import '../widget/text_fields.dart';
import '../widget/txt_with_link.dart';

class LocationView extends StatelessWidget {
  const LocationView({Key? key}) : super(key: key);
  static const String routeName = '/LocationView';


  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    return WillPopScope(
      onWillPop: () async => false,
      child: BaseScaffold(
        showAppBar: false,
        body:slide1(context),
      ),
    );
  }

  Widget slide1(BuildContext context){
    return Stack(
      children: [
        Image.asset(AppAssets.map,),
        Align(
          alignment: Alignment.bottomCenter,
          child: Material(
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 3.0),
              height: context.percentHeight * 35.0,
              width: double.infinity,

              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.percentHeight * 2.0,),

                  headline2(
                     'Location',
                      color: AppColors.blackColor
                  ),
                  SizedBox(height: context.percentHeight * 2.0,),
                  subText3('2972 Westheimer Rd. Santa Ana, Illinois 85486 '),
                  subText3('2118 Thornridge Cir. Syracuse, Connecticut 35624'),
                  SizedBox(height: context.percentHeight * 6.0,),
                  InkWell(
                    onTap: (){

                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      margin:  EdgeInsets.symmetric(horizontal: 10,vertical: context.percentHeight * 1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.redColor
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(Lang.star,style: TextStyle(color: AppColors.white,fontSize: 18),),
                          SizedBox(width: context.percentWidth * 3.0,),
                          Image.asset(AppAssets.startIcon)
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),

          ),
        ),

      ],
    );
  }
}
