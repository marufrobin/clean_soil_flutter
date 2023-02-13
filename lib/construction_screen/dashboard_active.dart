// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:clean_soil_flutter/google_map/google_map.dart';
import 'package:flutter/material.dart';

class DashboardActive extends StatefulWidget {
  var data;
  var projectSiteLocationLat;
  var projectSiteLocationLng;
  DashboardActive(
      {super.key,
      required this.data,
      required this.projectSiteLocationLat,
      required this.projectSiteLocationLng});

  @override
  State<DashboardActive> createState() => _DashboardActiveState();
}

class _DashboardActiveState extends State<DashboardActive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: ((context) => CustomGoogleMap())),
                    );
                  },
                  child: Card(
                    elevation: 0.5,
                    child: ListTile(
                      title: Text(
                        "${widget.data[index]["projectName"]}",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff212121),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFPro'),
                      ),
                      subtitle: Text(
                        "Lafarge worksite to processer",
                        style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff6E6E6E),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFPro'),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 16,
                      ),
                    ),
                  ),
                ),
            separatorBuilder: (_, index) => SizedBox(
                  height: 1,
                ),
            itemCount: widget.data.length),
      ),
    );
  }
}
