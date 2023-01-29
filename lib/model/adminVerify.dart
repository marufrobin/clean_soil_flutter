class adminVerify {
  String? email;
  String? code;

  adminVerify({this.email, this.code});

  adminVerify.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['code'] = this.code;
    return data;
  }
}
