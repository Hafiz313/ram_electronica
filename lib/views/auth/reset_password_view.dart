
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/consts/assets.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import 'package:ram_elettronica/views/auth/forget_view.dart';
import 'package:ram_elettronica/views/auth/password_update_view.dart';
import 'package:ram_elettronica/views/base_views/base_scaffold_auth.dart';
import 'package:ram_elettronica/views/widget/text_button.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../main.dart';
import '../base_views/mainView.dart';
import '../widget/buttons.dart';
import '../widget/text.dart';
import '../widget/text_fields.dart';
import '../widget/txt_with_link.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({Key? key}) : super(key: key);

  static const String routeName = '/RestPasswordView';
  final _formKey = GlobalKey<FormState>();

  final newPasswordTxtField = TextEditingController();
  final passwordTxtField = TextEditingController();
  bool _isChecked = false;


  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    final watch = context.watch<AuthViewModel>();
    return WillPopScope(
      onWillPop: () async => false,
      child: BaseScaffoldAuth(
        showBackButton:true,
        body: Expanded(
          child: Form(
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
                      headline1(Lang.resetYourPassword,color: AppColors.blackColor,),
                      SizedBox(
                        height: context.percentHeight * 2.0,
                      ),
                      subText2(Lang.resetYourPasswordDescription,align: TextAlign.start),
                      SizedBox(
                        height: context.percentHeight * 4.0,
                      ),

                      Column(
                        children: [
                          CustomTxtField(
                            hintTxt: Lang.password,
                            isHiddenPassword: !watch.isShowPassword,
                            textEditingController: passwordTxtField,
                            prefixIcon: const Icon(FontAwesomeIcons.lock,color: AppColors.textColor,),
                            suffixIcon: InkWell(
                                onTap: ()=> read.toggleVisibility(),
                                child:  Icon(!watch.isShowPassword?FontAwesomeIcons.solidEye:FontAwesomeIcons.eyeSlash,color: AppColors.textColor,)),
                            validator: (String? val) {
                              if (val == null || val.isEmpty) {
                                return 'New password cannot be empty.';
                              } else if (val.length < 5) {
                                return 'Password must be at least 5 characters long.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: context.percentHeight * 2.0,
                          ),
                          CustomTxtField(
                            hintTxt: '${Lang.newTxt} ${Lang.password}',
                            isHiddenPassword: !watch.isShowPassword,
                            textEditingController: newPasswordTxtField,
                            prefixIcon: const Icon(FontAwesomeIcons.lock,color: AppColors.textColor,),
                            suffixIcon: InkWell(
                                onTap: ()=> read.toggleVisibility(),
                                child:  Icon(!watch.isShowPassword?FontAwesomeIcons.solidEye:FontAwesomeIcons.eyeSlash,color: AppColors.textColor,)),
                            validator: (String? val) {
                              if (val == null || val.isEmpty) {
                                return 'New password cannot be empty.';
                              } else if (val.length < 5) {
                                return 'Password must be at least 5 characters long.';
                              }
                              else if (val != passwordTxtField.text) {
                                return 'Passwords do not match.';
                              }
                              return null;
                            },
                          ),



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

                          if(_formKey.currentState!.validate()){

                            final String? argument = ModalRoute.of(context)?.settings.arguments as String?;
                            read.resetPassword(email: argument!,password:passwordTxtField.text,newPassword: newPasswordTxtField.text ,callBack: (isSuccess) {
                              if (isSuccess) {
                                navigate.currentState?.pushNamed(PasswordUpdateView.routeName);
                              }
                            });

                          }



                          // if (emailTxtField.text.isNotEmpty) {
                          //
                          //   navigate.currentState?.pushNamed(OtpView.routeName);
                          //   // read.login(
                          //   //     userName: emailTxtField.text,
                          //   //     password: passwordTxtField.text,
                          //   //     callBack: (isSuccess) {
                          //   //       if (isSuccess) {
                          //   //         // Navigator.pushNamed(
                          //   //         //     context, HomeView.routeName);
                          //   //       }
                          //   //     }
                          //   //
                          //   // );
                          // } else {
                          //   Fluttertoast.showToast(
                          //       msg: Lang.enterYourEmail,
                          //       //Empty
                          //       toastLength: Toast.LENGTH_SHORT,
                          //       gravity: ToastGravity.SNACKBAR,
                          //       timeInSecForIosWeb: 2,
                          //       backgroundColor: Colors.red,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0);
                          // }
                        },
                        title: '${Lang.reset} ${Lang.password}',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
