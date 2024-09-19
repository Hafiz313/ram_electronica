
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ram_elettronica/consts/assets.dart';
import 'package:ram_elettronica/utils/percentage_size_ext.dart';
import 'package:ram_elettronica/views/auth/reset_password_view.dart';
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

class OtpView extends StatefulWidget {
  const OtpView({Key? key}) : super(key: key);

  static const String routeName = '/OtpView';

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final _formKey = GlobalKey<FormState>();

  final _otpController = List<TextEditingController>.generate(4, (_) => TextEditingController());
  final _focusNodes = List<FocusNode>.generate(4, (_) => FocusNode());
  late Timer _timer;
  int _start = 59;
  void startTimer() {
    _start = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });

  }
  String getOtpText() {
    return _otpController.map((controller) => controller.text).join();
  }
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }
  @override
  void dispose() {
    _otpController.forEach((controller) => controller.dispose());
    _focusNodes.forEach((node) => node.dispose());
    super.dispose();
  }
  void _onOtpChanged(int index, String value) {
    if (value.length == 1 && index < 3) {
      FocusScope.of(context).nextFocus();
    } else if (value.length == 0 && index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

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
                      headline1(Lang.otpVerification,color: AppColors.blackColor,),
                      SizedBox(
                        height: context.percentHeight * 2.0,
                      ),
                      subText2(Lang.otpVerificationDescription,align: TextAlign.start),
                      SizedBox(
                        height: context.percentHeight * 4.0,
                      ),

                      Column(
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(4, (index) {
                                return Container(
                                  width: 50,
                                  height: 50,
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  child: TextFormField(
                                    controller: _otpController[index],
                                    focusNode: _focusNodes[index],
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    decoration: const InputDecoration(
                                      counterText: '',
                                      hintText: "-",
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color:AppColors.textColor),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1, color: AppColors.textColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1, color: AppColors.textColor),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: AppColors.redColor),
                                      ),
                                    ),
                                    onChanged: (value) => _onOtpChanged(index, value),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(
                            height: context.percentHeight * 12.0,
                          ),
                          Text(
                            '00:$_start',
                            style: const TextStyle(fontSize: 26),
                          ),
                          SizedBox(
                            height: context.percentHeight * 5.0,
                          ),

                          Container(
                            alignment: Alignment.center,
                            child: txtWithLink(txt: Lang.didNtGetCode, linkTxt: Lang.resendCode,linkTxtColor:_start==0?AppColors.redColor:AppColors.textColor, onTap: (){

                              // if(_start==0){
                                final String? argument = ModalRoute.of(context)?.settings.arguments as String?;
                                debugPrint("=========argument: ${argument}===========");
                                read.forget(email: argument!,callBack: (isSuccess) {
                                  if (isSuccess) {
                                    startTimer();
                                  }
                                });
                                //
                              // }

                            // child: txtWithLink(txt: Lang.didNtGetCode, linkTxt: Lang.resendCode,linkTxtColor:_start==0?AppColors.bgGrayColor:AppColors.redColor , onTap: (){

                            }),
                          )



                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: EdgeInsets.only(bottom: context.percentHeight * 2.0),
                      child: AppElevatedButton(
                        onPressed: () async {
                          //TODO:: dumy user just for testing

                          debugPrint("===========_otpController.length: ${getOtpText()}======");

                          if(getOtpText().length > 3){

                            final String? argument = ModalRoute.of(context)?.settings.arguments as String?;
                            debugPrint("=========argument: ${argument}===========");
                            read.verifyOTP(email:argument! ,otp: getOtpText(),callBack: (isSuccess) {
                              if (isSuccess) {
                                navigate.currentState?.pushNamed(ResetPasswordView.routeName,arguments:argument);

                              }
                            });
                            // navigate.currentState?.pushNamed(OtpView.routeName);
                          }

                          else{

                              Fluttertoast.showToast(
                                  msg: "Please fill this Otp",
                                  //Empty
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.SNACKBAR,
                                  timeInSecForIosWeb: 2,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);

                            }


                          // if(_otpController.length <4 ){

                          // navigate.currentState?.pushNamed(ResetPasswordView.routeName);

                          // if (emailTxtField.text.isNotEmpty &&
                          //     passwordTxtField.text.isNotEmpty) {
                          //   read.login(
                          //       userName: emailTxtField.text,
                          //       password: passwordTxtField.text,
                          //       callBack: (isSuccess) {
                          //         if (isSuccess) {
                          //           // Navigator.pushNamed(
                          //           //     context, HomeView.routeName);
                          //         }
                          //       }
                          //
                          //   );
                          // } else {
                          //   Fluttertoast.showToast(
                          //       msg: "Username & Password are required",
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
