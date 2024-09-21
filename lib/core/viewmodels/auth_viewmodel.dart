import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:ram_elettronica/utils/MyRepo.dart';
import 'package:ram_elettronica/utils/app_constands.dart';
import '../../main.dart';
import '../../networking/api_provider.dart';
import '../../networking/api_ref.dart';
import '../../utils/helper.dart';
import '../../utils/preferences.dart';
import '../models/response/forget_password_response.dart';
import '../models/response/login_response.dart';
import 'base_viewmodel.dart';

class AuthViewModel extends BaseViewModel {


  bool isChecked = false;
  bool isShowPassword = false;
  bool isRestShowPassword = false;
  // bool isRestShowNewPassword = false;
  Future<bool> checkAuth() async {
    String? token = await Preferences.getUserToken();
    if (token != null && token.isNotEmpty) {
      return true;
    }
    return false;
  }

  void toggleVisibility() {
    isShowPassword = !isShowPassword;
    notifyListeners();
  }
  void toggleRestVisibility() {
    isRestShowPassword = !isRestShowPassword;
    notifyListeners();
  }

  void checked({bool? value}) {
    isChecked =value!;
    notifyListeners();
  }
  void savePassword() {
    final box = GetStorage();
    box.write(kRememberMe, 'true');
    notifyListeners();
  }
  void removePassword() {
    final box = GetStorage();
    box.remove(kRememberMe);
    notifyListeners();
  }

  Future<String> getName() async {
    String? name = await Preferences.getUserName();

    if (name != null && name.isNotEmpty) {
      notifyListeners();
      return name;
    }
    return '';
  }





  Future<void> saveUserInfo({required LoginResponse response}) async {
    await Preferences.setUserToken(response.user!.token!);
    await Preferences.setUserId(response.user!.id!);
    await Preferences.setUserName(response.user!.name!);
    await Preferences.setUserEmail(response.user!.email!);
    await Preferences.setUserRole(response.user!.role!);
    // await Preferences.setUserImageUrl('${response.user!.employee!.profileImg!}');
  }

  void login(
      {required String email,
      required String password,
      required Function(bool) callBack}) async {

    debugPrint("======email: ${email}========");
    debugPrint("======password: ${password}========");
    var url = Apis.loginApi;

    var helper = ApiProvider(navigate.currentContext, url, {
      'email': email,
      'password': password,
    });
    await helper.postApiData(
      isAuth: true,
      showSuccess: false,
    ).then(
      (res) async {
        print("=========login:${res}=========");
        if (!isNullString(res)) {
          LoginResponse response = LoginResponse.fromJson(jsonDecode(res));
          if (response.success!) {
            Fluttertoast.showToast(
                msg: 'Login Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);

            if(isChecked){

              savePassword();
            }
            else{
              removePassword();
            }
          await MyRepo.savePrefData(response.user!);
            saveUserInfo(response: response);
            callBack(true);
          } else {
            Fluttertoast.showToast(
                msg: "Invalid Token, Please login again",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
        else {
          Fluttertoast.showToast(
              msg: "Invalid login, Please login again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
    );
  }

  void logOut(
      {
        required Function(bool) callBack}) async {
    var url = Apis.logOutApi;
    var helper = ApiProvider(navigate.currentContext, url, {});
    await helper.postApiData(
      isAuth: true,
      showSuccess: false,
    ).then(
          (res) async {
        print("=========login:${res}=========");
        if (!isNullString(res)) {
          LoginResponse response = LoginResponse.fromJson(jsonDecode(res));
          if (response.success!) {
            Fluttertoast.showToast(
                msg: 'Logout Successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);

            callBack(true);
          } else {
            Fluttertoast.showToast(
                msg: "Invalid Token, try again",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
        else {
          Fluttertoast.showToast(
              msg: "Invalid login, Please login again",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
    );
  }

  void forget(
      {required String email,
        required Function(bool) callBack}) async {
    var url = Apis.forgetPasswordApi;
    // var helper = ApiProvider(navigate.currentContext, url, {'email': email});
    var helper = ApiProvider(navigate.currentContext, url, {'email': "m.shhaid3313@gmail.come"});
    await helper
        .postApiData(
      isAuth: true,
      showSuccess: false,
    ).then(
          (res) async {
        print("====url:${url}=======");
        print("====forget:${res}====");
        if (!isNullString(res)) {
          ForgetPasswordResponse response = ForgetPasswordResponse.fromJson(jsonDecode(res));

          Fluttertoast.showToast(
              msg: response.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          callBack(true);


        }
        else {
          Fluttertoast.showToast(
              msg: 'Try Again',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
    );
  }

  void resetPassword(
      { required String email,
        required String password,
        required String newPassword,
        required Function(bool) callBack}) async {
    var url = Apis.resetPasswordApi;
    var helper = ApiProvider(navigate.currentContext, url, {'email': email,'password':password,'password_confirmation':newPassword});
    await helper
        .postApiData(
      isAuth: true,
      showSuccess: false,
    ).then(
          (res) async {
        print("====url:${url}=======");
        print("====email:${email}=======");
        print("====password:${password}=======");
        print("====newPassword:${newPassword}=======");
        print("====forget:${res}====");
        if (!isNullString(res)) {
          ForgetPasswordResponse response = ForgetPasswordResponse.fromJson(jsonDecode(res));

          Fluttertoast.showToast(
              msg: response.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          callBack(true);


        }
        else {
          Fluttertoast.showToast(
              msg: 'Try Again',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
    );
  }

  void verifyOTP(
      {required String email,required String otp,
        required Function(bool) callBack}) async {
    var url = Apis.verifyOTPApi;
    var helper = ApiProvider(navigate.currentContext, url, {'email': email,'otp': otp,});
    await helper
        .postApiData(
      isAuth: true,
      showSuccess: false,
    ).then(
          (res) async {
        print("====url:${url}=======");
        print("====forget:${res}====");
        if (!isNullString(res)) {
          ForgetPasswordResponse response = ForgetPasswordResponse.fromJson(jsonDecode(res));

          Fluttertoast.showToast(
              msg: response.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          callBack(true);


        }
        else {
          Fluttertoast.showToast(
              msg: 'Try Again',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
    );
  }


  void signup(
  File? image,
      {required String userName,
        required String password,
        required String email,
        required String name,
        required String surName,
        required BuildContext context,
        }

        ) async {
    String url = Apis.baseUrl+Apis.signupApi;
    var headers = {
      'Authorization': 'eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo0LCJleHAiOjE2OTk3MTkyMDd9.t2vOUl9Z7Z3bW_sfyKbrB-DVC4MGzenqoAQ1WMAKFI0'
    };

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'username': userName,
      'password': password,
      'email': email,
      'name': userName,
      'sur_name': surName
    });
    if(isNullString(image.toString())) {
      request.files.add(await http.MultipartFile.fromPath('images', image!.path));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    EasyLoading.dismiss();

    print("========${response.statusCode}: ${response}=========");


    if (response.statusCode == 200 || response.statusCode ==201) {
      response.stream.transform(utf8.decoder).listen((value) {

        // LoginResponse response = LoginResponse.fromJson(jsonDecode(value));
        Fluttertoast.showToast(
            msg: "User created successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.SNACKBAR,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pop(context);
        // saveUserInfo(response: response);
        // Navigator.pushNamed(
        //     context, HomeView.routeName);


      });
      // Fluttertoast.showToast(
      //     msg: "User created successfully",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.SNACKBAR,
      //     timeInSecForIosWeb: 2,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 16.0);
      // LoginResponse response = LoginResponse.fromJson(jsonDecode(response.));
      // saveUserInfo(response: response);
    }else{


      Fluttertoast.showToast(
          msg: "User already create",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);

    }
  }
}

final RegExp emailExp = RegExp("^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9]"
    "(?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:/."
    "[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*.[a-zA-Z0-9]");

