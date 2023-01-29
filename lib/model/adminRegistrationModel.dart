class UserRegistrationModel {
  bool? success;
  String? message;
  Data? data;

  UserRegistrationModel({this.success, this.message, this.data});

  UserRegistrationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? sId;
  String? fullName;
  String? email;
  String? userCompanyType;
  String? userType;
  String? userPosition;
  String? status;

  Data(
      {this.sId,
      this.fullName,
      this.email,
      this.userCompanyType,
      this.userType,
      this.userPosition,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    userCompanyType = json['userCompanyType'];
    userType = json['userType'];
    userPosition = json['userPosition'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    data['userCompanyType'] = this.userCompanyType;
    data['userType'] = this.userType;
    data['userPosition'] = this.userPosition;
    data['status'] = this.status;
    return data;
  }
}
