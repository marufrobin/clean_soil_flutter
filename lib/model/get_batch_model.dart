class GetAllBatchModel {
  bool? success;
  List<Data>? data;

  GetAllBatchModel({this.success, this.data});

  GetAllBatchModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  ApprovedBy? approvedBy;
  PickupSite? pickupSite;
  PickupSite? dropSite;
  String? sId;
  String? projectId;
  int? batchNumber;
  String? soilType;
  String? materialQuantity;
  String? status;
  String? createdAt;
  int? iV;

  Data(
      {this.approvedBy,
      this.pickupSite,
      this.dropSite,
      this.sId,
      this.projectId,
      this.batchNumber,
      this.soilType,
      this.materialQuantity,
      this.status,
      this.createdAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    approvedBy = json['approvedBy'] != null
        ? new ApprovedBy.fromJson(json['approvedBy'])
        : null;
    pickupSite = json['pickupSite'] != null
        ? new PickupSite.fromJson(json['pickupSite'])
        : null;
    dropSite = json['dropSite'] != null
        ? new PickupSite.fromJson(json['dropSite'])
        : null;
    sId = json['_id'];
    projectId = json['projectId'];
    batchNumber = json['batchNumber'];
    soilType = json['soilType'];
    materialQuantity = json['materialQuantity'];
    status = json['status'];
    createdAt = json['created_at'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.approvedBy != null) {
      data['approvedBy'] = this.approvedBy!.toJson();
    }
    if (this.pickupSite != null) {
      data['pickupSite'] = this.pickupSite!.toJson();
    }
    if (this.dropSite != null) {
      data['dropSite'] = this.dropSite!.toJson();
    }
    data['_id'] = this.sId;
    data['projectId'] = this.projectId;
    data['batchNumber'] = this.batchNumber;
    data['soilType'] = this.soilType;
    data['materialQuantity'] = this.materialQuantity;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    return data;
  }
}

class ApprovedBy {
  String? sId;
  String? fullName;
  String? role;

  ApprovedBy({this.sId, this.fullName, this.role});

  ApprovedBy.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['role'] = this.role;
    return data;
  }
}

class PickupSite {
  String? siteName;
  String? location;

  PickupSite({this.siteName, this.location});

  PickupSite.fromJson(Map<String, dynamic> json) {
    siteName = json['siteName'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['siteName'] = this.siteName;
    data['location'] = this.location;
    return data;
  }
}
