
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../../networking/api_provider.dart';
import '../../networking/api_ref.dart';
import '../../utils/helper.dart';
import '../../utils/preferences.dart';
import '../models/response/current_hours_response.dart';
import '../models/response/login_response.dart';
import 'base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  CurrentHoursResponse response =CurrentHoursResponse();
  // bool loading =false;
  void checkIn(
      {required Function(bool) callBack}) async {
    var url = Apis.checkInApi;
    var helper = ApiProvider(navigate.currentContext, url, {});
    await helper
        .postApiData2(
      isAuth: true,
      showSuccess: false,
    ).then(
          (res) async {
        print("====url:${url}=======");
        print("====start:${res}====");
        if (!isNullString(res)) {

          Fluttertoast.showToast(
              msg: 'Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          callBack(true);
          // getCurrentHours(callBack: (isSuccess) {});
          // LoginResponse response = LoginResponse.fromJson(jsonDecode(res));
          // if (response.success!) {
          //
          //   Fluttertoast.showToast(
          //       msg: 'Successfully',
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.SNACKBAR,
          //       timeInSecForIosWeb: 2,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          //   callBack(true);
          // } else {
          //   Fluttertoast.showToast(
          //       msg: "Invalid Email",
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.SNACKBAR,
          //       timeInSecForIosWeb: 2,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          // }
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

  void breakStart(
      {required Function(bool) callBack}) async {
    var url = Apis.startBreakApi;
    var helper = ApiProvider(navigate.currentContext, url, {});
    await helper
        .postApiData2(
      isAuth: true,
      showSuccess: false,
    ).then(
          (res) async {
        print("====url:${url}=======");
        print("====start:${res}====");
        if (!isNullString(res)) {
          callBack(true);
          Fluttertoast.showToast(
              msg: 'Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          // getCurrentHours(callBack: (isSuccess) {});
          // LoginResponse response = LoginResponse.fromJson(jsonDecode(res));
          // if (response.success!) {
          //
          //   Fluttertoast.showToast(
          //       msg: 'Successfully',
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.SNACKBAR,
          //       timeInSecForIosWeb: 2,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          //   callBack(true);
          // } else {
          //   Fluttertoast.showToast(
          //       msg: "Invalid Email",
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.SNACKBAR,
          //       timeInSecForIosWeb: 2,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          // }
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
  void breakEnd(
      {required Function(bool) callBack}) async {
    var url = Apis.endBreakApi;
    var helper = ApiProvider(navigate.currentContext, url, {});
    await helper
        .postApiData2(
      isAuth: true,
      showSuccess: false,
    ).then(
          (res) async {
        print("====url:${url}=======");
        print("====start:${res}====");
        if (!isNullString(res)) {
          callBack(true);
          Fluttertoast.showToast(
              msg: 'Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

         // getCurrentHours(callBack: (isSuccess) {});
          // LoginResponse response = LoginResponse.fromJson(jsonDecode(res));
          // if (response.success!) {
          //
          //   Fluttertoast.showToast(
          //       msg: 'Successfully',
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.SNACKBAR,
          //       timeInSecForIosWeb: 2,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          //   callBack(true);
          // } else {
          //   Fluttertoast.showToast(
          //       msg: "Invalid Email",
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.SNACKBAR,
          //       timeInSecForIosWeb: 2,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          // }
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

  void checkout(
      {required Function(bool) callBack}) async {
    var url = Apis.checkOutApi;
    var helper = ApiProvider(navigate.currentContext, url, {});
    await helper
        .postApiData2(
      isAuth: true,
      showSuccess: false,
    ).then(
          (res) async {
        print("====url:${url}=======");
        print("====start:${res}====");
        if (!isNullString(res)) {
          callBack(true);
          Fluttertoast.showToast(
              msg: 'Successfully',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          // getCurrentHours(callBack: (isSuccess) {});
          // LoginResponse response = LoginResponse.fromJson(jsonDecode(res));
          // if (response.success!) {
          //
          //   Fluttertoast.showToast(
          //       msg: 'Successfully',
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.SNACKBAR,
          //       timeInSecForIosWeb: 2,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          //   callBack(true);
          // } else {
          //   Fluttertoast.showToast(
          //       msg: "Invalid Email",
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.SNACKBAR,
          //       timeInSecForIosWeb: 2,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0);
          // }
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

  Future<void> getCurrentHours(
      {required Function(bool) callBack}) async {


    var url = Apis.currentHourApi;

    var helper = ApiProvider(navigate.currentContext, url, {});
    await helper
        .getApiData(
    ).then(
          (res) async {

            debugPrint("======res: ${res}=========");


        if (!isNullString(res)) {
          response= CurrentHoursResponse.fromJson(jsonDecode(res));
          callBack(true);
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

    notifyListeners();
  }
}


