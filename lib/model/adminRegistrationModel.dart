class AdminRegistrationModel {
  bool? success;
  String? message;
  Data? data;

  AdminRegistrationModel({this.success, this.message, this.data});

  AdminRegistrationModel.fromJson(Map<String, dynamic> json) {
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
  int? iV;

  Data(
      {this.sId,
      this.companyType,
      this.companyName,
      this.fullName,
      this.workEmail,
      this.joined,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    companyType = json['companyType'];
    companyName = json['companyName'];
    fullName = json['fullName'];
    workEmail = json['workEmail'];
    joined = json['joined'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['companyType'] = this.companyType;
    data['companyName'] = this.companyName;
    data['fullName'] = this.fullName;
    data['workEmail'] = this.workEmail;
    data['joined'] = this.joined;
    data['__v'] = this.iV;
    return data;
  }
}
