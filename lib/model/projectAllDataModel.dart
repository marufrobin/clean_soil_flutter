class ProjectAllDataModel {
  bool? success;
  List<Data>? data;

  ProjectAllDataModel({this.success, this.data});

  ProjectAllDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data?.add(new Data.fromJson(v));
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
  AssignedUsers? assignedUsers;
  ConstructionCompany? constructionCompany;
  ConstructionCompany? haulerCompany;
  ConstructionCompany? processorCompany;
  ProjectSite? projectSite;
  String? sId;
  String? projectName;
  String? materialQuality;
  String? materialQuantity;
  String? createdAt;
  int? iV;
  String? status;

  Data(
      {this.assignedUsers,
      this.constructionCompany,
      this.haulerCompany,
      this.processorCompany,
      this.projectSite,
      this.sId,
      this.projectName,
      this.materialQuality,
      this.materialQuantity,
      this.createdAt,
      this.iV,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    assignedUsers = json['assignedUsers'] != null
        ? new AssignedUsers.fromJson(json['assignedUsers'])
        : null;
    constructionCompany = json['constructionCompany'] != null
        ? new ConstructionCompany.fromJson(json['constructionCompany'])
        : null;
    haulerCompany = json['haulerCompany'] != null
        ? new ConstructionCompany.fromJson(json['haulerCompany'])
        : null;
    processorCompany = json['processorCompany'] != null
        ? new ConstructionCompany.fromJson(json['processorCompany'])
        : null;
    projectSite = json['projectSite'] != null
        ? new ProjectSite.fromJson(json['projectSite'])
        : null;
    sId = json['_id'];
    projectName = json['projectName'];
    materialQuality = json['materialQuality'];
    materialQuantity = json['materialQuantity'];
    createdAt = json['created_at'];
    iV = json['__v'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.assignedUsers != null) {
      data['assignedUsers'] = this.assignedUsers!.toJson();
    }
    if (this.constructionCompany != null) {
      data['constructionCompany'] = this.constructionCompany!.toJson();
    }
    if (this.haulerCompany != null) {
      data['haulerCompany'] = this.haulerCompany!.toJson();
    }
    if (this.processorCompany != null) {
      data['processorCompany'] = this.processorCompany!.toJson();
    }
    if (this.projectSite != null) {
      data['projectSite'] = this.projectSite!.toJson();
    }
    data['_id'] = this.sId;
    data['projectName'] = this.projectName;
    data['materialQuality'] = this.materialQuality;
    data['materialQuantity'] = this.materialQuantity;
    data['created_at'] = this.createdAt;
    data['__v'] = this.iV;
    data['status'] = this.status;
    return data;
  }
}

class AssignedUsers {
  List<dynamic>? haulerCompany;
  List<dynamic>? processorCompany;
  List<ConstuctionCompany>? constuctionCompany;

  AssignedUsers(
      {this.haulerCompany, this.processorCompany, this.constuctionCompany});

  AssignedUsers.fromJson(Map<String, dynamic> json) {
    // if (json['haulerCompany'] != null) {
    //   haulerCompany = <dynamic>[];
    //   json['haulerCompany'].forEach((v) {
    //     haulerCompany!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['processorCompany'] != null) {
    //   processorCompany = new List<Null>();
    //   json['processorCompany'].forEach((v) {
    //     processorCompany.add(new Null.fromJson(v));
    //   });
    // }
    if (json['constuctionCompany'] != null) {
      constuctionCompany = <ConstuctionCompany>[];
      json['constuctionCompany'].forEach((v) {
        constuctionCompany!.add(new ConstuctionCompany.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.haulerCompany != null) {
      data['haulerCompany'] =
          this.haulerCompany!.map((v) => v.toJson()).toList();
    }
    if (this.processorCompany != null) {
      data['processorCompany'] =
          this.processorCompany!.map((v) => v.toJson()).toList();
    }
    if (this.constuctionCompany != null) {
      data['constuctionCompany'] =
          this.constuctionCompany!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ConstuctionCompany {
  String? sId;
  String? fullName;
  String? role;

  ConstuctionCompany({this.sId, this.fullName, this.role});

  ConstuctionCompany.fromJson(Map<String, dynamic> json) {
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

class ConstructionCompany {
  bool? isAccepted;
  String? sId;
  String? name;

  ConstructionCompany({this.isAccepted, this.sId, this.name});

  ConstructionCompany.fromJson(Map<String, dynamic> json) {
    isAccepted = json['isAccepted'];
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAccepted'] = this.isAccepted;
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class ProjectSite {
  String? siteName;
  String? location;

  ProjectSite({this.siteName, this.location});

  ProjectSite.fromJson(Map<String, dynamic> json) {
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
