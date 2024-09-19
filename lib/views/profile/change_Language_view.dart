
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/consts/assets.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import 'package:ram_elettronica/views/auth/forget_view.dart';
import 'package:ram_elettronica/views/auth/password_update_view.dart';
import 'package:ram_elettronica/views/base_views/base_scaffold_auth.dart';
import 'package:ram_elettronica/views/profile/password_change_view.dart';
import 'package:ram_elettronica/views/widget/text_button.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../main.dart';
import '../base_views/base_scaffold.dart';
import '../base_views/mainView.dart';
import '../widget/buttons.dart';
import '../widget/text.dart';
import '../widget/text_fields.dart';
import '../widget/txt_with_link.dart';

class ChangeLanguageView extends StatelessWidget {
  ChangeLanguageView({Key? key}) : super(key: key);

  static const String routeName = '/ChangeLanguageView';
  final _formKey = GlobalKey<FormState>();
  final newPasswordTxtField = TextEditingController();
  final passwordTxtField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    return WillPopScope(
      onWillPop: () async => false,
      child: BaseScaffold(
        showBackButton:false,
        body: Form(
          key: _formKey,
          child: Container(
            color: AppColors.white,
            padding:
            EdgeInsets.symmetric(vertical: context.percentHeight * 2.0,horizontal: context.percentWidth * 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: context.percentHeight * 5.0,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: context.percentWidth * 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: ()=>Navigator.pop(context),
                          child: const Icon(FontAwesomeIcons.arrowLeft,size: 18,)),
                      headline2(Lang.language,color: AppColors.blackColor),
                      const Icon(FontAwesomeIcons.arrowLeft,color: AppColors.transparent,),
                    ],),
                ),
                SizedBox(height: context.percentHeight * 5.0,),

                radioButton(Lang.english,AppAssets.englishFlag, 1, 1, (p0) {


                }),
                Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: .7 ,width: double.infinity,color: AppColors.textColor,),
                radioButton(Lang.italian,AppAssets.italianFlag, 1, 1, (p0) {


                }),


              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget radioButton(String text, String imageUrl, num value, num selectedRadioTile, Function(num) setSelectedRadioTile) {
    return RadioListTile(
      value: value,
      activeColor: AppColors.redColor,
      tileColor: AppColors.white,
      controlAffinity: ListTileControlAffinity.trailing, // Move the radio circle to the right
      groupValue: selectedRadioTile,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 30,
            width: 30,
            child: Image.asset(imageUrl),
          ),
          const SizedBox(width: 10,),
          Text(text, style: TextStyle(color: AppColors.blackColor),),
        ],
      ),
      onChanged: (val) {
        setSelectedRadioTile(val as num);
        print("Radio Tile pressed $val --> $selectedRadioTile");
      },
    );
  }



}
