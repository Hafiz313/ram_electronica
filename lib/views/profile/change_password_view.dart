
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

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({Key? key}) : super(key: key);

  static const String routeName = '/ChangePasswordView';
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
            padding:
            EdgeInsets.symmetric(vertical: context.percentHeight * 2.0,horizontal: context.percentWidth * 4.0),
            child: Stack(
              children: [
                Column(
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
                          headline2(Lang.changePassword,color: AppColors.textColor),
                          const Icon(FontAwesomeIcons.arrowLeft,color: AppColors.transparent,),
                        ],),
                    ),

                    subText2(Lang.changePasswordDescription,align: TextAlign.start),
                    SizedBox(
                      height: context.percentHeight * 6.0,
                    ),

                    Column(
                      children: [
                        textFiled(context, title: '${Lang.current} ${Lang.password} ', hintText: Lang.password, textEditingController: passwordTxtField),
                        SizedBox(
                          height: context.percentHeight * 2.0,
                        ),
                        textFiled(context, title: '${Lang.newTxt} ${Lang.password}', hintText: '${Lang.newTxt} ${Lang.password}', textEditingController: newPasswordTxtField)

                      ],
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: context.percentHeight * 2.0,top: context.percentHeight * 2.0),
                    child: AppElevatedButton(
                      onPressed: () async {

                        //TODO:: dumy user just for testing
                        navigate.currentState?.pushNamed(PasswordChangeView.routeName);

                        if (newPasswordTxtField.text.isNotEmpty) {

                          //
                          // read.login(
                          //     userName: emailTxtField.text,
                          //     password: passwordTxtField.text,
                          //     callBack: (isSuccess) {
                          //       if (isSuccess) {
                          //         // Navigator.pushNamed(
                          //         //     context, HomeView.routeName);
                          //       }
                          //     }
                          //
                          // );
                        } else {
                          Fluttertoast.showToast(
                              msg: '${Lang.empty}!',
                              //Empty
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.SNACKBAR,
                              timeInSecForIosWeb: 2,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      },
                      title: Lang.saveChanges,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget textFiled(BuildContext context,{required String title,required String hintText,   required TextEditingController textEditingController}){
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
