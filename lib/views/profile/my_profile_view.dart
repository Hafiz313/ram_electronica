import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:ram_elettronica/utils/app_constands.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';

import '../../consts/assets.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../base_views/base_scaffold.dart';
import '../widget/text.dart';
import '../widget/text_fields.dart';

class MyProfileView extends StatelessWidget {
   MyProfileView({super.key});
  static const String routeName = '/MyProfileView';

  final employeeIdTxtField = TextEditingController();
  final employeeNameTxtField = TextEditingController();
  final emailTxtField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child:  BaseScaffold(
          showBackButton:false,
          body: Column(
            children: [
              SizedBox(height: context.percentHeight * 5.0,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                        onTap: ()=>Navigator.pop(context),
                        child: const Icon(FontAwesomeIcons.arrowLeft,size: 18,)),
                    headline2(Lang.myProfile,color: AppColors.blackColor),
                    const Icon(FontAwesomeIcons.arrowLeft,color: AppColors.transparent,),
                  ],),
              ),
              SizedBox(height: context.percentHeight * 2.0,),
              Container(
                  alignment: Alignment.center,
                  child: Image.asset(AppAssets.avatar)),
              SizedBox(height: context.percentWidth * 2,),
              textFiled(context, title: '${Lang.employee} ${Lang.id}', hintText: '${GetStorage().read(kUserID)}', textEditingController: employeeIdTxtField,),
              textFiled(context, title: '${Lang.employee} ${Lang.name}', hintText: '${GetStorage().read(kName)}', textEditingController: employeeNameTxtField),
              textFiled(context, title: Lang.email, hintText: '${GetStorage().read(kEmailID)}', textEditingController: emailTxtField),
              textFiled(context, title: Lang.designation, hintText: '${GetStorage().read(kDesignation)}', textEditingController: emailTxtField),
              textFiled(context, title: Lang.dob, hintText: '${GetStorage().read(kDOB)}', textEditingController: emailTxtField),
            ],
          )
      ),
    );
  }

  Widget textFiled(BuildContext context,{required String title,required String hintText,   required TextEditingController textEditingController, bool enable =false}){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: context.percentWidth * 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        subText5(title,color: AppColors.blackColor),
        SizedBox(height: context.percentHeight * 1.5,),
        CustomTxtField(
          hintTxt: hintText,
          enabled: !enable,
          textEditingController: textEditingController,
          // validator: (String? val) {
          //   if (val!.isEmpty) {
          //     return 'Please enter Password';
          //   }
          //   return null;
          // },
        ),
        SizedBox(height: context.percentHeight * 2,),
      ],),
    );
  }


}
