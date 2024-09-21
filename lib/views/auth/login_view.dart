import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import 'package:ram_elettronica/views/HomeView/home_view.dart';
import 'package:ram_elettronica/views/auth/forget_view.dart';
import 'package:ram_elettronica/views/base_views/base_scaffold_auth.dart';
import 'package:ram_elettronica/views/widget/text_button.dart';
import '../../consts/colors.dart';
import '../../consts/lang.dart';
import '../../core/viewmodels/auth_viewmodel.dart';
import '../../main.dart';
import '../../utils/app_constands.dart';
import '../base_views/mainView.dart';
import '../widget/buttons.dart';
import '../widget/text.dart';
import '../widget/text_fields.dart';




class LoginView extends StatelessWidget {
   LoginView({super.key});
  static const String routeName = '/loginView';

  final _formKey = GlobalKey<FormState>();

  final emailTxtField = TextEditingController();

  final passwordTxtField = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final read = context.read<AuthViewModel>();
    final watch = context.watch<AuthViewModel>();

    GetStorage().write(kIntroCheck, '0');
    if(GetStorage().hasData(kRememberMe)){

      context.watch<AuthViewModel>().checked(value:true);
      emailTxtField.text = GetStorage().read(kEmailID) ?? '';
      passwordTxtField.text = GetStorage().read(kPassword)?? '';
    }


    return WillPopScope(
      onWillPop: () async => false,
      child: BaseScaffoldAuth(
        showBackButton:false,
        body: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Padding(
                padding:
                EdgeInsets.symmetric(vertical: context.percentHeight * 2.0,horizontal: context.percentWidth * 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    headline1(Lang.welcomeBack,color: AppColors.blackColor,),
                    SizedBox(
                      height: context.percentHeight * 1.0,
                    ),
                    subText2(Lang.letContinue,align: TextAlign.start),
                    SizedBox(
                      height: context.percentHeight * 2.0,
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
                          height: context.percentHeight * 2.0,
                        ),
                        CustomTxtField(
                          hintTxt: Lang.password,
                          isHiddenPassword: !watch.isShowPassword,
                          textEditingController: passwordTxtField,
                          prefixIcon: const Icon(FontAwesomeIcons.lock,color: AppColors.textColor,),
                          suffixIcon: InkWell(
                              onTap: ()=> read.toggleVisibility(),
                              child:  Icon(!watch.isShowPassword?FontAwesomeIcons.solidEye:FontAwesomeIcons.eyeSlash,color: AppColors.textColor,)),
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  side:  const BorderSide(color: AppColors.redColor),
                                  value: watch.isChecked,
                                  onChanged: ( newValue) {
                                    read.checked(value:newValue);
          
                                  },
                                ),
                                subText3(Lang.rememberMe,color: AppColors.redColor),
                              ],
                            ),
                            AppTextButton(
                                textStyle: const TextStyle(color: AppColors.btnBgColor),
                                title: '${Lang.forgot} ${Lang.password} ?',
                                onPressed: ()=>  navigate.currentState?.pushNamed(ForgetView.routeName)
          
                            ),
                          ],
                        ),
                        SizedBox(height: context.percentHeight * 10.0,),
          
                        AppElevatedButton(
                          onPressed: () async {
                            if(_formKey.currentState!.validate()){
                              if (emailTxtField.text.isNotEmpty &&
                                  passwordTxtField.text.isNotEmpty) {
                                // if(watch.isChecked){
          
          
                                read.login(
                                    email: emailTxtField.text,
                                    password: passwordTxtField.text,
                                    callBack: (isSuccess) {
                                      if (isSuccess) {
                                        // Navigator.pushNamed(
                                        //     context, MainView.routeName);
                                        Navigator.pushReplacementNamed(context,  MainView.routeName);
                                      }
                                    }
                                );
          
                                if(watch.isChecked){
                                  GetStorage().write(kPassword, "${passwordTxtField.text}");
                                }
          
          
                                // }
                                // else{
                                //   Fluttertoast.showToast(
                                //       msg: "Please check the 'Rxemember Me' box",
                                //       //Empty
                                //       toastLength: Toast.LENGTH_SHORT,
                                //       gravity: ToastGravity.SNACKBAR,
                                //       timeInSecForIosWeb: 2,
                                //       backgroundColor: Colors.red,
                                //       textColor: Colors.white,
                                //       fontSize: 16.0);
                                // }
          
                              } else {
                                Fluttertoast.showToast(
                                    msg: "${Lang.enterYourEmail} and ${Lang.password}",
                                    //Empty
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.SNACKBAR,
                                    timeInSecForIosWeb: 2,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            }
                          },
                          title: Lang.signIn,
                        ),
          
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


