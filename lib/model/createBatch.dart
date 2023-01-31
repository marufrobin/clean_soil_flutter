class CreateBatch {
  String? projectId;
  String? batchNumber;
  ApprovedBy? approvedBy;
  String? soilType;
  String? materialQuantity;
  PickupSite? pickupSite;
  PickupSite? dropSite;

  CreateBatch(
      {this.projectId,
      this.batchNumber,
      this.approvedBy,
      this.soilType,
      this.materialQuantity,
      this.pickupSite,
      this.dropSite});

  CreateBatch.fromJson(Map<String, dynamic> json) {
    projectId = json['projectId'];
    batchNumber = json['batchNumber'];
    approvedBy = json['approvedBy'] != null
        ? new ApprovedBy.fromJson(json['approvedBy'])
        : null;
    soilType = json['soilType'];
    materialQuantity = json['materialQuantity'];
    pickupSite = json['pickupSite'] != null
        ? new PickupSite.fromJson(json['pickupSite'])
        : null;
    dropSite = json['dropSite'] != null
        ? new PickupSite.fromJson(json['dropSite'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['projectId'] = this.projectId;
    data['batchNumber'] = this.batchNumber;
    if (this.approvedBy != null) {
      data['approvedBy'] = this.approvedBy!.toJson();
    }
    data['soilType'] = this.soilType;
    data['materialQuantity'] = this.materialQuantity;
    if (this.pickupSite != null) {
      data['pickupSite'] = this.pickupSite!.toJson();
    }
    if (this.dropSite != null) {
      data['dropSite'] = this.dropSite!.toJson();
    }
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
