class LoginResponse {
  bool? success;
  User? user;

  LoginResponse({this.success, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? phone;
  String? role;
  String? otp;
  int? status;
  String? createdAt;
  String? updatedAt;
  String? token;
  Employee? employee;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.phone,
        this.role,
        this.otp,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.token,
        this.employee});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    phone = json['phone'];
    role = json['role'];
    otp = json['otp'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    token = json['token'];
    employee = json['employee'] != null
        ? new Employee.fromJson(json['employee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['otp'] = this.otp;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['token'] = this.token;
    if (this.employee != null) {
      data['employee'] = this.employee!.toJson();
    }
    return data;
  }
}

class Employee {
  int? id;
  int? userId;
  String? designation;
  String? profileImg;
  String? dob;
  String? createdAt;
  String? updatedAt;

  Employee(
      {this.id,
        this.userId,
        this.designation,
        this.profileImg,
        this.dob,
        this.createdAt,
        this.updatedAt});

  Employee.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    designation = json['designation'];
    profileImg = json['profile_img'];
    dob = json['dob'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['designation'] = this.designation;
    data['profile_img'] = this.profileImg;
    data['dob'] = this.dob;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
