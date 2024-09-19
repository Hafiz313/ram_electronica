import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stylish_dialog/stylish_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;
import '../consts/enums.dart';
import '../utils/preferences.dart';
import '../views/auth/login_view.dart';
import '../views/widget/custom_dialog.dart';
import '../views/widget/customer_Loader.dart';
import 'api_ref.dart';

enum RequestMethod { get, post, put, delete }

class ApiProvider {
  var context;
  var url;
  var bodyData;
  var imagePath;


   ApiProvider(this.context, this.url, this.bodyData,);

  getApiData({ bool showLoader = false}) async {
    try {
      print("=======wwww:${Apis.baseUrl + url}=======");

      // if (await checkInternetConnection()) {
      // if (showLoader) showCustomLoader();
      // var headers = {
      //   'Authorization': '••••••',
      //   'Cookie': 'XSRF-TOKEN=eyJpdiI6ImFGQzRXbjBwb1F1OEVpdGRvRWVhdFE9PSIsInZhbHVlIjoibm1DK21MWXlXb1RzbFJ5alp6THlKb1ZlS0RVcGxPc2g2ZE1hMjU2Zk9PYUczMEFCTFhTeTN2dWhabTlUNytMbUw4SENReHUzWUxVZzFJaDM1MU04dytOYmYxQlRaaUhxWE9SbzA1M0pPQXdpYkxBRmpHajBjVWcxT3lmblU1MkgiLCJtYWMiOiIwMGE3NTQ5ODViZDA5MTY4YmNkMDYwMjdlMWQ0N2YzZDJmMzRlYmJmZTg3MmNlMzRkZGJiZGYwN2VkODc4MDYwIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjJheVJTNG1uN0J3V2dJaC95WERHd0E9PSIsInZhbHVlIjoiVmNiYW93M3VEclFSWWRvL1Y3MUJiY3dLV2pTa3d4M3dKMzBMTFdvd09Yd2VxYjhmc0JqVmViTG9sR3NPdTJ4ZW9IVHZsbGRDK2NrbG81aFh5MHdGNWxOVEZEejNWNXd0SXhQcVVKejZKZ0ZTQUxpQmJEWm9ySEdhK0JXd1FpVTgiLCJtYWMiOiI1NmExMWQ3ZGM4OWYwOTRjMmIzODlkZjY3Y2VjMTlkNDA0MjQ3ZWZiZDY2OThiNGFiZGY5MGE3YWVkNzM0YTQ2IiwidGFnIjoiIn0%3D'
      // };
      var headers =  await getApiHeaders2();
        var request = http.Request('GET', Uri.parse(Apis.baseUrl + url));
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
        EasyLoading.dismiss();

        debugPrint("=====response.statusCode: ${response.statusCode}=======");

        if (response.statusCode == 200) {
          // var success = jsonDecode(response.body)['success'];
          // var error = jsonDecode(response.body)['error'];
          // var message = jsonDecode(response.body)['message'];
          //
          // if (success) {
          return await response.stream.bytesToString();
          // } else if (error) {
          //   FeedbackNotification().feedback(
          //     context,
          //     genericFeedbackStyle(
          //       Languages.of(context)?.somethingWrong,
          //       message,
          //       something_went_wrong_image,
          //     ),
          //   );
          // }
        } else if (response.statusCode == 401) {
          // FeedbackNotification().feedback(
          //   context,
          //   genericFeedbackStyle(
          //     Languages.of(context)?.unauthorized,
          //     Languages.of(context)?.sessionExpired,
          //     alert,
          //     true,
          //   ),
          // );

          await CustomDialog(
                  stylishDialogType: StylishDialogType.WARNING,
                  msg: "Session Expired", //Empty
                  dismissible: false,
                  callBack: () async {
                    ///Logout current User

                    //TODO:: implement logout here
                    // await logOut(context);
                    await Preferences.deleteUserToken();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      LoginView.routeName,
                      ModalRoute.withName('/'),
                    );
                  })
              .show();
        } else {
          var message =
              jsonDecode(await response.stream.bytesToString())['message'];

          if (message != null && message.toString().isNotEmpty) {
            //TODO:: show dialog
            // FeedbackNotification().feedback(
            //   context,
            //   genericFeedbackStyle(
            //     Languages
            //         .of(context)
            //         ?.somethingWrong,
            //     message,
            //     something_went_wrong_image,
            //   ),
            // );
          } else {
            //TODO:: show dialog
            // FeedbackNotification().feedback(
            //   context,
            //   genericFeedbackStyle(
            //     Languages
            //         .of(context)
            //         ?.somethingWrong,
            //     response.reasonPhrase,
            //     something_went_wrong_image,
            //   ),
            // );
          }
        }
      // }
      //
      // else {
      //   //TODO:: show dialog
      //   // FeedbackNotification().feedback(
      //   //   context,
      //   //   genericFeedbackStyle(
      //   //     Languages.of(context)?.noInternetConnection,
      //   //     Languages.of(context)?.checkInternet,
      //   //     no_internet,
      //   //   ),
      //   // );
      //
      //   return AppConfigEnum.noInternet.key.toString();
      // }
    } catch (exception) {
      // only executed if error is of type Exception
      //TODO:: show dialog
      // FeedbackNotification().feedback(
      //   context,
      //   genericFeedbackStyle(
      //     Languages.of(context)?.somethingWrong,
      //     exception.toString(),
      //     something_went_wrong_image,
      //   ),
      // );
    }

    return "";
  }

  Future postApiData(
      {isAuth = true,
      bool showLoader = true,
      bool showSuccess = true,
      String successMsg = ""}) async {
    try {

      print("=======${Apis.baseUrl + url}=======");

      // if (await checkInternetConnection()) {
        if (showLoader) showCustomLoader();
        var headers = await getApiHeaders(isAuth);
        var request = http.Request('POST', Uri.parse(Apis.baseUrl + url));
        request.body = json.encode(bodyData);
        request.headers.addAll(headers);
        http.StreamedResponse response = await request.send();
      print("=======statusCode:${response.statusCode}=======");
        EasyLoading.dismiss();
        if (response.statusCode == 200 || response.statusCode ==201) {
          if (showSuccess) {
            await CustomDialog(
              stylishDialogType: StylishDialogType.SUCCESS,
              msg: successMsg,
            ).show();
          }

          //TODO:: show success
          // var message =
          //     jsonDecode(await response.stream.bytesToString())['message'];
          // FeedbackNotification().feedback(
          //   context,
          //   genericFeedbackStyle(
          //     "Success", //Empty
          //     message,
          //     success,
          //     true,
          //   ),
          // );

          // var success =
          //     jsonDecode(await response.stream.bytesToString())['success'];
          // var error =
          //     jsonDecode(await response.stream.bytesToString())['error'];
          // var message =
          //     jsonDecode(await response.stream.bytesToString())['message'];
          //
          // if (success) {
          return await response.stream.bytesToString();
        }
        // else if (error) {
        //     FeedbackNotification().feedback(
        //       context,
        //       genericFeedbackStyle(
        //         Languages.of(context)?.somethingWrong,
        //         message,
        //         something_went_wrong_image,
        //       ),
        //     );
        //   }
        //}
        else if (response.statusCode == 401) {
          //TODO:: show dialog
          // FeedbackNotification().feedback(
          //   context,
          //   genericFeedbackStyle(
          //     Languages.of(context)?.unauthorized,
          //     Languages.of(context)?.sessionExpired,
          //     alert,
          //     true,
          //   ),
          // );
        } else {
          var message =
              jsonDecode(await response.stream.bytesToString())['message'];

          if (message != null && message.toString().isNotEmpty) {
            //TODO:: show dialog
            // FeedbackNotification().feedback(
            //   context,
            //   genericFeedbackStyle(
            //     Languages.of(context)?.somethingWrong,
            //     message,
            //     something_went_wrong_image,
            //   ),
            // );
          } else {
            //TODO:: show dialog
            // FeedbackNotification().feedback(
            //   context,
            //   genericFeedbackStyle(
            //     Languages.of(context)?.somethingWrong,
            //     response.reasonPhrase,
            //     something_went_wrong_image,
            //   ),
            // );
          }
        }
      // }
      // else {
      //   //TODO:: show dialog
      //   // FeedbackNotification().feedback(
      //   //   context,
      //   //   genericFeedbackStyle(
      //   //     Languages.of(context)?.noInternetConnection,
      //   //     Languages.of(context)?.checkInternet,
      //   //     no_internet,
      //   //   ),
      //   // );
      // }
    } catch (exception) {
      // // only executed if error is of type Exception
      // FeedbackNotification().feedback(
      //   context,
      //   genericFeedbackStyle(
      //     Languages.of(context)?.somethingWrong,
      //     exception.message.toString(),
      //     something_went_wrong_image,
      //   ),
      // );
    }

    return "";
  }
  Future postApiData2(
      {isAuth = true,
        bool showLoader = true,
        bool showSuccess = true,
        String successMsg = ""}) async {
    try {

      print("=======wwww:${Apis.baseUrl + url}=======");

      // if (await checkInternetConnection()) {
      // if (showLoader) showCustomLoader();
      // var headers = {
      //   'Authorization': '••••••',
      //   'Cookie': 'XSRF-TOKEN=eyJpdiI6ImFGQzRXbjBwb1F1OEVpdGRvRWVhdFE9PSIsInZhbHVlIjoibm1DK21MWXlXb1RzbFJ5alp6THlKb1ZlS0RVcGxPc2g2ZE1hMjU2Zk9PYUczMEFCTFhTeTN2dWhabTlUNytMbUw4SENReHUzWUxVZzFJaDM1MU04dytOYmYxQlRaaUhxWE9SbzA1M0pPQXdpYkxBRmpHajBjVWcxT3lmblU1MkgiLCJtYWMiOiIwMGE3NTQ5ODViZDA5MTY4YmNkMDYwMjdlMWQ0N2YzZDJmMzRlYmJmZTg3MmNlMzRkZGJiZGYwN2VkODc4MDYwIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6IjJheVJTNG1uN0J3V2dJaC95WERHd0E9PSIsInZhbHVlIjoiVmNiYW93M3VEclFSWWRvL1Y3MUJiY3dLV2pTa3d4M3dKMzBMTFdvd09Yd2VxYjhmc0JqVmViTG9sR3NPdTJ4ZW9IVHZsbGRDK2NrbG81aFh5MHdGNWxOVEZEejNWNXd0SXhQcVVKejZKZ0ZTQUxpQmJEWm9ySEdhK0JXd1FpVTgiLCJtYWMiOiI1NmExMWQ3ZGM4OWYwOTRjMmIzODlkZjY3Y2VjMTlkNDA0MjQ3ZWZiZDY2OThiNGFiZGY5MGE3YWVkNzM0YTQ2IiwidGFnIjoiIn0%3D'
      // };
      var headers =  await getApiHeaders2();
      // {
      //   'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3JhbWVsZXR0cm9uaWNhLm5ldC9hcGkvYXV0aC9sb2dpbiIsImlhdCI6MTcyNTg5MDU1MiwiZXhwIjoxNzI1ODk0MTUyLCJuYmYiOjE3MjU4OTA1NTIsImp0aSI6IjVtRzdPaElkMzhBSXFGaWgiLCJzdWIiOiI0IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.l--ep_e-AkQ4kiaR92EX9kMA7fT28FEDpnnQS8h8BhA', // Ensure valid token
      // };
      // headers = {
      //   'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3JhbWVsZXR0cm9uaWNhLm5ldC9hcGkvYXV0aC9sb2dpbiIsImlhdCI6MTcyNTg5MDU1MiwiZXhwIjoxNzI1ODk0MTUyLCJuYmYiOjE3MjU4OTA1NTIsImp0aSI6IjVtRzdPaElkMzhBSXFGaWgiLCJzdWIiOiI0IiwicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyJ9.l--ep_e-AkQ4kiaR92EX9kMA7fT28FEDpnnQS8h8BhA', // Ensure valid token
      // };
      var request = http.MultipartRequest('POST', Uri.parse(Apis.baseUrl + url));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      print("=======statusCode:${response.statusCode}=======");
      EasyLoading.dismiss();
      if (response.statusCode == 200 || response.statusCode ==201) {
        if (showSuccess) {
          await CustomDialog(
            stylishDialogType: StylishDialogType.SUCCESS,
            msg: successMsg,
          ).show();
        }
        return await response.stream.bytesToString();
      }
      else if (response.statusCode == 401) {
        //TODO:: show dialog
        // FeedbackNotification().feedback(
        //   context,
        //   genericFeedbackStyle(
        //     Languages.of(context)?.unauthorized,
        //     Languages.of(context)?.sessionExpired,
        //     alert,
        //     true,
        //   ),
        // );
      } else {
        var message = jsonDecode(await response.stream.bytesToString())['message'];

        if (message != null && message.toString().isNotEmpty) {
          //TODO:: show dialog
          // FeedbackNotification().feedback(
          //   context,
          //   genericFeedbackStyle(
          //     Languages.of(context)?.somethingWrong,
          //     message,
          //     something_went_wrong_image,
          //   ),
          // );
        } else {
          //TODO:: show dialog
          // FeedbackNotification().feedback(
          //   context,
          //   genericFeedbackStyle(
          //     Languages.of(context)?.somethingWrong,
          //     response.reasonPhrase,
          //     something_went_wrong_image,
          //   ),
          // );
        }
      }

    } catch (exception) {
      print("=======exception:${exception}=======");
      // // only executed if error is of type Exception
      // FeedbackNotification().feedback(
      //   context,
      //   genericFeedbackStyle(
      //     Languages.of(context)?.somethingWrong,
      //     exception.message.toString(),
      //     something_went_wrong_image,
      //   ),
      // );
    }

    return "";
  }
  Future postApiDataWithImage(
      {isAuth = true,
        bool showLoader = true,
        bool showSuccess = true,
        String successMsg = ""}) async {
    try {
      if (await checkInternetConnection()) {
        if (showLoader) showCustomLoader();
        var headers = await getApiHeaders(isAuth);
        var request = http.Request(
            RequestMethod.post.name, Uri.parse(Apis.baseUrl + url));
        request.body = json.encode(bodyData);
        request.body = json.encode(bodyData);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        EasyLoading.dismiss();
        print("=======response.statusCode:${response.statusCode}=======");

        if (response.statusCode == 200 || response.statusCode ==201) {
          if (showSuccess) {
            await CustomDialog(
              stylishDialogType: StylishDialogType.SUCCESS,
              msg: successMsg,
            ).show();
          }

          //TODO:: show success
          // var message =
          //     jsonDecode(await response.stream.bytesToString())['message'];
          // FeedbackNotification().feedback(
          //   context,
          //   genericFeedbackStyle(
          //     "Success", //Empty
          //     message,
          //     success,
          //     true,
          //   ),
          // );

          // var success =
          //     jsonDecode(await response.stream.bytesToString())['success'];
          // var error =
          //     jsonDecode(await response.stream.bytesToString())['error'];
          // var message =
          //     jsonDecode(await response.stream.bytesToString())['message'];
          //
          // if (success) {
          return await response.stream.bytesToString();
        }
        // else if (error) {
        //     FeedbackNotification().feedback(
        //       context,
        //       genericFeedbackStyle(
        //         Languages.of(context)?.somethingWrong,
        //         message,
        //         something_went_wrong_image,
        //       ),
        //     );
        //   }
        //}
        else if (response.statusCode == 401) {
          //TODO:: show dialog
          // FeedbackNotification().feedback(
          //   context,
          //   genericFeedbackStyle(
          //     Languages.of(context)?.unauthorized,
          //     Languages.of(context)?.sessionExpired,
          //     alert,
          //     true,
          //   ),
          // );
        } else {
          var message =
          jsonDecode(await response.stream.bytesToString())['message'];

          if (message != null && message.toString().isNotEmpty) {
            //TODO:: show dialog
            // FeedbackNotification().feedback(
            //   context,
            //   genericFeedbackStyle(
            //     Languages.of(context)?.somethingWrong,
            //     message,
            //     something_went_wrong_image,
            //   ),
            // );
          } else {
            //TODO:: show dialog
            // FeedbackNotification().feedback(
            //   context,
            //   genericFeedbackStyle(
            //     Languages.of(context)?.somethingWrong,
            //     response.reasonPhrase,
            //     something_went_wrong_image,
            //   ),
            // );
          }
        }
      }
      else {
        //TODO:: show dialog
        // FeedbackNotification().feedback(
        //   context,
        //   genericFeedbackStyle(
        //     Languages.of(context)?.noInternetConnection,
        //     Languages.of(context)?.checkInternet,
        //     no_internet,
        //   ),
        // );
      }
    } catch (exception) {
      // // only executed if error is of type Exception
      // FeedbackNotification().feedback(
      //   context,
      //   genericFeedbackStyle(
      //     Languages.of(context)?.somethingWrong,
      //     exception.message.toString(),
      //     something_went_wrong_image,
      //   ),
      // );
    }

    return "";
  }

  putApiData(
      {isAuth = true,
      bool showLoader = true,
      bool showSuccess = true,
      String successMsg = ""}) async {
    try {
      if (await checkInternetConnection()) {
        if (showLoader) showCustomLoader();
        var headers = await getApiHeaders(isAuth);
        var request =
            http.Request(RequestMethod.put.name, Uri.parse(Apis.baseUrl + url));

        print(json.encode(bodyData));
        print("///////////");
        print(bodyData);
        request.body = json.encode(bodyData);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        EasyLoading.dismiss();
        if (response.statusCode == 200) {
          if (showSuccess) {
            await CustomDialog(
              stylishDialogType: StylishDialogType.SUCCESS,
              msg: successMsg,
            ).show();
          }

          // var success =
          //     jsonDecode(await response.stream.bytesToString())['success'];
          // var error =
          //     jsonDecode(await response.stream.bytesToString())['error'];
          // var message =
          //     jsonDecode(await response.stream.bytesToString())['message'];
          //
          // if (success) {
          return await response.stream.bytesToString();
        }
        // else if (error) {
        //     FeedbackNotification().feedback(
        //       context,
        //       genericFeedbackStyle(
        //         Languages.of(context)?.somethingWrong,
        //         message,
        //         something_went_wrong_image,
        //       ),
        //     );
        //   }
        //}
        else if (response.statusCode == 401) {
          //TODO:: show dialog
          // FeedbackNotification().feedback(
          //   context,
          //   genericFeedbackStyle(
          //     Languages.of(context)?.unauthorized,
          //     Languages.of(context)?.sessionExpired,
          //     alert,
          //     true,
          //   ),
          // );
        } else {
          var message =
              jsonDecode(await response.stream.bytesToString())['message'];

          if (message != null && message.toString().isNotEmpty) {
            //TODO:: show dialog
            // FeedbackNotification().feedback(
            //   context,
            //   genericFeedbackStyle(
            //     Languages.of(context)?.somethingWrong,
            //     message,
            //     something_went_wrong_image,
            //   ),
            // );
          } else {
            //TODO:: show dialog
            // FeedbackNotification().feedback(
            //   context,
            //   genericFeedbackStyle(
            //     Languages.of(context)?.somethingWrong,
            //     response.reasonPhrase,
            //     something_went_wrong_image,
            //   ),
            // );
          }
        }
      } else {
        //TODO:: show dialog
        // FeedbackNotification().feedback(
        //   context,
        //   genericFeedbackStyle(
        //     Languages.of(context)?.noInternetConnection,
        //     Languages.of(context)?.checkInternet,
        //     no_internet,
        //   ),
        // );
      }
    } catch (exception) {
      // // only executed if error is of type Exception
      // FeedbackNotification().feedback(
      //   context,
      //   genericFeedbackStyle(
      //     Languages.of(context)?.somethingWrong,
      //     exception.message.toString(),
      //     something_went_wrong_image,
      //   ),
      // );
    }

    return "";
  }

  deleteApiData(
      {isAuth = true,
      bool showLoader = true,
      bool showSuccess = true,
      String successMsg = "Players Delete Successfully"}) async {
    try {
      if (await checkInternetConnection()) {
        if (showLoader) showCustomLoader();
        var headers = await getApiHeaders(isAuth);
        var request = http.Request(
            RequestMethod.delete.name, Uri.parse(Apis.baseUrl + url));
        request.body = json.encode(bodyData);
        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();
        EasyLoading.dismiss();
        print("=========response.statusCode:${response.statusCode}======");

        if (response.statusCode == 200) {
          if (showSuccess) {
            await CustomDialog(
              stylishDialogType: StylishDialogType.SUCCESS,
              msg: successMsg,
            ).show();
          }

          return await response.stream.bytesToString();
        } else if (response.statusCode == 401) {
          //TODO:: show dialog
          // FeedbackNotification().feedback(
          //   context,
          //   genericFeedbackStyle(
          //     Languages.of(context)?.unauthorized,
          //     Languages.of(context)?.sessionExpired,
          //     alert,
          //     true,
          //   ),
          // );
        } else {
          var message =
              jsonDecode(await response.stream.bytesToString())['message'];

          if (message != null && message.toString().isNotEmpty) {
            //TODO:: show dialog
            // FeedbackNotification().feedback(
            //   context,
            //   genericFeedbackStyle(
            //     Languages.of(context)?.somethingWrong,
            //     message,
            //     something_went_wrong_image,
            //   ),
            // );
          } else {
            // FeedbackNotification().feedback(
            //   context,
            //   genericFeedbackStyle(
            //     Languages.of(context)?.somethingWrong,
            //     response.reasonPhrase,
            //     something_went_wrong_image,
            //   ),
            // );
          }
        }
      } else {
        // FeedbackNotification().feedback(
        //   context,
        //   genericFeedbackStyle(
        //     Languages.of(context)?.noInternetConnection,
        //     Languages.of(context)?.checkInternet,
        //     no_internet,
        //   ),
        // );
      }
    } catch (exception) {
      // // only executed if error is of type Exception
      // FeedbackNotification().feedback(
      //   context,
      //   genericFeedbackStyle(
      //     Languages.of(context)?.somethingWrong,
      //     exception.message.toString(),
      //     something_went_wrong_image,
      //   ),
      // );
    }

    return "";
  }

  Future<Map<String, String>> getApiHeaders(bool isAuth) async {
    final String? token = await Preferences.getUserToken();

    // return {
    //   'Content-Type': 'application/json',
    //   'Authorization': isAuth ? token ?? "" : "",
    // };
    return {
      'Accept': '',
      'Content-Type': 'application/json'
    };
  }
  Future<Map<String, String>> getApiHeaders2() async {
    final String? token = await Preferences.getUserToken();
    return {
      'Authorization': 'Bearer $token'
    };
  }

  checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
