// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:clean_soil_flutter/construction_screen/allbatch.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardActive extends StatefulWidget {
  const DashboardActive({super.key});

  @override
  State<DashboardActive> createState() => _DashboardActiveState();
}

class _DashboardActiveState extends State<DashboardActive> {
  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";
  var DashBoadactiveUrl = "project/get-assigned-projects-by-user";
  String userId = "63dbe295137a82239e717ab9";
  String userCompanyType = "construction";
  Map<String, dynamic>? allData;

  dashBoardactive() async {
    var DashBoardallUrl =
        "$baseUrl$apiVersionUrl$DashBoadactiveUrl?userId=$userId&userCompanyType=$userCompanyType";

    var responce = await http.get(
      Uri.parse(DashBoardallUrl),
      headers: {'Content-Type': 'application/json'},
    );

    var dashboadall = await http.get(Uri.parse(DashBoardallUrl));
    allData = Map<String, dynamic>.from(jsonDecode(dashboadall.body));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    dashBoardactive();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: ((context) => AllBatchPage())),
                    );
                  },
                  child: Card(
                    elevation: 0.5,
                    child: ListTile(
                      title: Text(
                        "Lafarge worksite",
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
            itemCount: 5),
      ),
    );
  }
}
