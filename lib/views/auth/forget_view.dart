
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/consts/assets.dart';
import 'package:ram_elettronica/main.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import 'package:ram_elettronica/views/auth/otp_view.dart';
import 'package:ram_elettronica/views/base_views/base_scaffold_auth.dart';
import 'package:ram_elettronica/views/widget/text_button.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../base_views/mainView.dart';
import '../widget/buttons.dart';
import '../widget/text.dart';
import '../widget/text_fields.dart';
import '../widget/txt_with_link.dart';

class ForgetView extends StatelessWidget {
  ForgetView({Key? key}) : super(key: key);

  static const String routeName = '/ForgetView';
  final _formKey = GlobalKey<FormState>();
  final emailTxtField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    return WillPopScope(
      onWillPop: () async => true,
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
                      headline1('${Lang.forgot} ${Lang.password}',color: AppColors.blackColor,),
                      SizedBox(
                        height: context.percentHeight * 2.0,
                      ),
                      subText2(Lang.letContinue,align: TextAlign.start),
                      SizedBox(
                        height: context.percentHeight * 4.0,
                      ),

                      Column(
                        children: [
                          CustomTxtField(
                            hintTxt: Lang.enterYourEmail,
                            textEditingController: emailTxtField,
                            prefixIcon: const Icon(FontAwesomeIcons.solidEnvelope,color: AppColors.textColor,),
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                return 'Please enter Email';
                              }
                              if (!emailExp.hasMatch(val)) {
                                return 'Please enter valid Email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: context.percentHeight * 4.0,
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
                          debugPrint("=====emailTxtField.text:${emailTxtField.text}=======");
                          if(_formKey.currentState!.validate()){
                            read.forget(email: emailTxtField.text,callBack: (isSuccess) {
                              if (isSuccess) {
                                navigate.currentState?.pushNamed(OtpView.routeName,arguments:emailTxtField.text );
                              }
                            });
                            // navigate.currentState?.pushNamed(OtpView.routeName);
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
                        title: Lang.cntne,
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
