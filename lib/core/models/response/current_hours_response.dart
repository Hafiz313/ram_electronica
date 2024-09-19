class CurrentHoursResponse {
  String? message;
  String? currentTime;
  int? status;
  List<CurrentWorkingHours>? currentWorkingHours;

  CurrentHoursResponse({this.message, this.status, this.currentWorkingHours});

  CurrentHoursResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    currentTime = json['current_time'];
    status = json['status'];
    if (json['current_working_hours'] != null) {
      currentWorkingHours = <CurrentWorkingHours>[];
      json['current_working_hours'].forEach((v) {
        currentWorkingHours!.add( CurrentWorkingHours.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['current_time'] = this.currentTime;
    data['status'] = this.status;
    if (this.currentWorkingHours != null) {
      data['current_working_hours'] =
          this.currentWorkingHours!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CurrentWorkingHours {
  dynamic id;
  dynamic attendanceId;
  dynamic checkInTime;
  dynamic checkOutTime;
  dynamic totalWorkingHours;
  dynamic breakStartTime;
  dynamic breakEndTime;
  dynamic totalBreakHours;
  dynamic breakOverTime;
  dynamic statusState;
  dynamic createdAt;
  dynamic updatedAt;

  CurrentWorkingHours(
      {this.id,
        this.attendanceId,
        this.checkInTime,
        this.checkOutTime,
        this.totalWorkingHours,
        this.breakStartTime,
        this.breakEndTime,
        this.totalBreakHours,
        this.breakOverTime,
        this.statusState,
        this.createdAt,
        this.updatedAt});

  CurrentWorkingHours.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attendanceId = json['attendance_id'];
    checkInTime = json['check_in_time'];
    checkOutTime = json['check_out_time'];
    totalWorkingHours = json['total_working_hours'];
    breakStartTime = json['break_start_time'];
    breakEndTime = json['break_end_time'];
    totalBreakHours = json['total_break_hours'];
    breakOverTime = json['break_over_time'];
    statusState = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['attendance_id'] = this.attendanceId;
    data['check_in_time'] = this.checkInTime;
    data['check_out_time'] = this.checkOutTime;
    data['total_working_hours'] = this.totalWorkingHours;
    data['break_start_time'] = this.breakStartTime;
    data['break_end_time'] = this.breakEndTime;
    data['total_break_hours'] = this.totalBreakHours;
    data['break_over_time'] = this.breakOverTime;
    data['status'] = this.statusState;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
