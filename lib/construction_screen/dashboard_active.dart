// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constans/constans.dart';
import '../model/shared_preference.dart';
import 'allbatch.dart';

class DashboardActive extends StatefulWidget {
  var data;

  DashboardActive({
    super.key,
    required this.data,
  });

  @override
  State<DashboardActive> createState() => _DashboardActiveState();
}

class _DashboardActiveState extends State<DashboardActive> {
  var uCompanyType;
  getUserCompanyType() async {
    uCompanyType = await SharedPreference.getStringValueSP(userCompanyType);
    print("company type: $uCompanyType");
  }

  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";
  var DashBoadactiveUrl = "project/get-assigned-projects-by-user";

  Map<String, dynamic>? allData;
  // dynamic data;
  dynamic activeData;
  var projectSiteLocationLat;
  var projectSiteLocationLng;

  String? uId;
  List allActiveProjectData = [];
  Future dashBoardactive() async {
    uId = await SharedPreference.getStringValueSP(userId);
    uCompanyType = await SharedPreference.getStringValueSP(userCompanyType);
    var DashBoardallUrl =
        "$baseUrl$apiVersionUrl$DashBoadactiveUrl?userId=$uId&userCompanyType=$uCompanyType";

    var responce = await http.get(
      Uri.parse(DashBoardallUrl),
      headers: {'Content-Type': 'application/json'},
    );

    allData = Map<String, dynamic>.from(jsonDecode(responce.body));
    activeData = allData!["data"];
    // List data = [];
    // data.add(allData!["data"]);
    print("data from active;;;;;;;;;;$activeData");

    int length = 0;
    print("what is the data ${activeData.length}");
    for (int i = 0; i <= activeData.length; i++) {
      print("printing i$i");
      allActiveProjectData = activeData.where((status) {
        int index = activeData.length;

        return status["status"].toString().toLowerCase() == "active";
        /* print("this data $data");
      return data;*/
      }).toList();

      print("all the active project adding ${allActiveProjectData}");
    }
    print("all active project ${allActiveProjectData.length}");

    return allActiveProjectData;
  }

  @override
  void initState() {
    // data = widget.data;
    // print("Data from active: ${data.length}");
    getUserCompanyType();
    dashBoardactive();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: FutureBuilder(
              future: dashBoardactive(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.data == null ||
                    allActiveProjectData.isEmpty) {
                  return Container(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(),
                          Icon(Icons.warning, size: 50, color: Colors.amber),
                          SizedBox(height: 20),
                          Text(
                            "No project has been assigned",
                            style: TextStyle(fontSize: 22),
                          ),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.refresh))
                        ],
                      ));
                }
                return Container(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            print(index);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: ((context) => AllBatchPage(
                                        projectId: allActiveProjectData[index]
                                            ["_id"],
                                        projectName: allActiveProjectData[index]
                                            ["projectName"],
                                        index: index,
                                      ))),
                            );
                          },
                          child: Card(
                            elevation: 0.5,
                            child: ListTile(
                              title: Text(
                                "${allActiveProjectData[index]["projectName"]}",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff212121),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'SFPro'),
                              ),
                              subtitle: Text(
                                "${allActiveProjectData[index]["projectName"]} to ${uCompanyType}",
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
                        );
                      },
                      itemCount: allActiveProjectData.length),
                );
              })),
    );
  }
}
