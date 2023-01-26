class LoginModel {
  bool? success;
  String? message;
  Data? data;

  LoginModel({this.success, this.message, this.data});

  LoginModel.fromJson(Map<String, dynamic> json) {
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
  String? companyType;
  String? companyName;
  String? fullName;
  String? workEmail;
  String? joined;

  Data(
      {this.sId,
      this.companyType,
      this.companyName,
      this.fullName,
      this.workEmail,
      this.joined});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    companyType = json['companyType'];
    companyName = json['companyName'];
    fullName = json['fullName'];
    workEmail = json['workEmail'];
    joined = json['joined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['companyType'] = this.companyType;
    data['companyName'] = this.companyName;
    data['fullName'] = this.fullName;
    data['workEmail'] = this.workEmail;
    data['joined'] = this.joined;
    return data;
  }
}
