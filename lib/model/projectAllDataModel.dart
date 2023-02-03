class AutoGenerate {
  AutoGenerate({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final List<Data> data;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = List.from(json['data']).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.assignedUsers,
    required this.constructionCompany,
    required this.haulerCompany,
    required this.processorCompany,
    required this.projectSite,
    required this.id,
    required this.projectName,
    required this.materialQuality,
    required this.materialQuantity,
    required this.createdAt,
    required this.V,
    required this.status,
  });
  late final AssignedUsers assignedUsers;
  late final ConstructionCompany constructionCompany;
  late final HaulerCompany haulerCompany;
  late final ProcessorCompany processorCompany;
  late final ProjectSite projectSite;
  late final String id;
  late final String projectName;
  late final String materialQuality;
  late final String materialQuantity;
  late final String createdAt;
  late final int V;
  late final String status;

  Data.fromJson(Map<String, dynamic> json) {
    assignedUsers = AssignedUsers.fromJson(json['assignedUsers']);
    constructionCompany =
        ConstructionCompany.fromJson(json['constructionCompany']);
    haulerCompany = HaulerCompany.fromJson(json['haulerCompany']);
    processorCompany = ProcessorCompany.fromJson(json['processorCompany']);
    projectSite = ProjectSite.fromJson(json['projectSite']);
    id = json['_id'];
    projectName = json['projectName'];
    materialQuality = json['materialQuality'];
    materialQuantity = json['materialQuantity'];
    createdAt = json['created_at'];
    V = json['__v'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['assignedUsers'] = assignedUsers.toJson();
    _data['constructionCompany'] = constructionCompany.toJson();
    _data['haulerCompany'] = haulerCompany.toJson();
    _data['processorCompany'] = processorCompany.toJson();
    _data['projectSite'] = projectSite.toJson();
    _data['_id'] = id;
    _data['projectName'] = projectName;
    _data['materialQuality'] = materialQuality;
    _data['materialQuantity'] = materialQuantity;
    _data['created_at'] = createdAt;
    _data['__v'] = V;
    _data['status'] = status;
    return _data;
  }
}

class AssignedUsers {
  AssignedUsers({
    required this.haulerCompany,
    required this.processorCompany,
    required this.constuctionCompany,
  });
  late final List<dynamic> haulerCompany;
  late final List<dynamic> processorCompany;
  late final List<ConstuctionCompany> constuctionCompany;

  AssignedUsers.fromJson(Map<String, dynamic> json) {
    haulerCompany = List.castFrom<dynamic, dynamic>(json['haulerCompany']);
    processorCompany =
        List.castFrom<dynamic, dynamic>(json['processorCompany']);
    constuctionCompany = List.from(json['constuctionCompany'])
        .map((e) => ConstuctionCompany.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['haulerCompany'] = haulerCompany;
    _data['processorCompany'] = processorCompany;
    _data['constuctionCompany'] =
        constuctionCompany.map((e) => e.toJson()).toList();
    return _data;
  }
}

class ConstuctionCompany {
  ConstuctionCompany({
    required this.id,
    required this.fullName,
    required this.role,
  });
  late final String id;
  late final String fullName;
  late final String role;

  ConstuctionCompany.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    fullName = json['fullName'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['fullName'] = fullName;
    _data['role'] = role;
    return _data;
  }
}

class ConstructionCompany {
  ConstructionCompany({
    required this.isAccepted,
    required this.id,
    required this.name,
  });
  late final bool isAccepted;
  late final String id;
  late final String name;

  ConstructionCompany.fromJson(Map<String, dynamic> json) {
    isAccepted = json['isAccepted'];
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isAccepted'] = isAccepted;
    _data['_id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class HaulerCompany {
  HaulerCompany({
    required this.isAccepted,
    required this.id,
    required this.name,
  });
  late final bool isAccepted;
  late final String id;
  late final String name;

  HaulerCompany.fromJson(Map<String, dynamic> json) {
    isAccepted = json['isAccepted'];
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isAccepted'] = isAccepted;
    _data['_id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class ProcessorCompany {
  ProcessorCompany({
    required this.isAccepted,
    required this.id,
    required this.name,
  });
  late final bool isAccepted;
  late final String id;
  late final String name;

  ProcessorCompany.fromJson(Map<String, dynamic> json) {
    isAccepted = json['isAccepted'];
    id = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isAccepted'] = isAccepted;
    _data['_id'] = id;
    _data['name'] = name;
    return _data;
  }
}

class ProjectSite {
  ProjectSite({
    required this.siteName,
    required this.location,
  });
  late final String siteName;
  late final String location;

  ProjectSite.fromJson(Map<String, dynamic> json) {
    siteName = json['siteName'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['siteName'] = siteName;
    _data['location'] = location;
    return _data;
  }
}
