


import 'package:get_storage/get_storage.dart';

import '../core/models/response/login_response.dart';
import 'app_constands.dart';

class MyRepo{

  static savePrefData(User user) async {
    final box = GetStorage();
    box.write(kUserID, "${user!.id}");
    box.write(kEmailID, "${user!.email}");
    box.write(kPhoneID, "${user.phone}");
    box.write(kName, "${user.name}");
    box.write(kRole, "${user.role}");
    box.write(kToken, "${user.token}");
    box.write(kDesignation, "${user.employee!.designation}");
    box.write(kDOB, "${user.employee!.dob}");
    box.write(kProfileImg, "${user.employee!.profileImg}");
  }
}