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
