import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  const Preferences._();

  ///
  /// Instantiation of the SharedPreferences library
  ///
  static const String _kUserToken = "token";
  static const String _kUserID = "UserID";
  static const String _kUserName = "UserName";
  static const String _kUserEmail = "UserEmail";
  static const String _kUserImageUrl = "UserImageUrl";
  static const String _kUserRole = "UserRole";

  /// ------------------------------------------------------------
  /// Method that returns the user token
  /// ------------------------------------------------------------
  static Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUserToken);
  }

  /// ------------------------------------------------------------
  /// Method that returns the user ID
  /// ------------------------------------------------------------
  static Future<int?> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_kUserID);
  }
  /// ------------------------------------------------------------
  /// Method that returns the user Name
  /// ------------------------------------------------------------
  static Future<String?> getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("======ff:${prefs.getString(_kUserName)}=======");
    return prefs.getString(_kUserName);
  }
  /// ------------------------------------------------------------
  /// Method that returns the user Email
  /// ------------------------------------------------------------
  static Future<String?> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUserEmail);
  }
  /// ------------------------------------------------------------
  /// Method that returns the user Role
  /// ------------------------------------------------------------
  static Future<String?> getUserRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUserRole);
  }
  /// ------------------------------------------------------------
  /// Method that returns the user Image Url
  /// ------------------------------------------------------------
  static Future<String?> getUserUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_kUserImageUrl);
  }


  /// ----------------------------------------------------------
  /// Method that set the user token
  /// ----------------------------------------------------------
  static Future<bool> setUserToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kUserToken, value);
  }
  /// ----------------------------------------------------------
  /// Method that set the user ID
  /// ----------------------------------------------------------
  static Future<bool> setUserId(int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(_kUserID, value);
  }
  /// ----------------------------------------------------------
  /// Method that set the user Email
  /// ----------------------------------------------------------
  static Future<bool> setUserEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kUserEmail, value);
  }
  /// ----------------------------------------------------------
  /// Method that set the user User Name
  /// ----------------------------------------------------------
  static Future<bool> setUserName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kUserName, value.toString());
  }
  /// ----------------------------------------------------------
  /// Method that set the user User Image Url
  /// ----------------------------------------------------------
  static Future<bool> setUserImageUrl(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kUserImageUrl, value.toString());
  }
  /// ----------------------------------------------------------
  /// Method that set the user User Role
  /// ----------------------------------------------------------
  static Future<bool> setUserRole(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(_kUserRole, value.toString());
  }

  /// ----------------------------------------------------------
  /// Method that delete login user token
  /// ----------------------------------------------------------
  static Future<bool> deleteUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_kUserToken);
  }
}
