bool isNullString(String? value) {
  if (value == null || value.isEmpty) {
    return true;
  } else {
    return false;
  }
}
bool validateEmail(String email) {
  RegExp regExp = RegExp( r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$');
  return regExp.hasMatch(email);
}