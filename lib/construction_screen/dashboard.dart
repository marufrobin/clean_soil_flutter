// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables, non_constant_identifier_names, unnecessary_question_mark, prefer_const_declarations, unnecessary_brace_in_string_interps

import 'dart:convert';

import 'package:clean_soil_flutter/authentication/account_signIn.dart';
import 'package:clean_soil_flutter/construction_screen/dashboard_active.dart';
import 'package:clean_soil_flutter/construction_screen/dashboard_all.dart';
import 'package:clean_soil_flutter/model/shared_preference.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../constans/constans.dart';
import '../google_map/customGoogleMaps.dart';
// import '../google_map/google_map.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({
    Key? key,
    // required this.userId,
    required this.userCompanyType,
  }) : super(key: key);
  // String userId;
  String userCompanyType;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";
  var DashBoadactiveUrl = "project/get-assigned-projects-by-user";

  Map<String, dynamic>? allData;
  dynamic? data;
  dynamic? activeData;
  var projectSiteLocationLat;
  var projectSiteLocationLng;
  var processorSiteLocationLat;
  var processorSiteLocationLng;
  String? uId;
  String? uCompanyType;
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
    data = allData!["data"];
    print("data:::$allData");
    projectSiteLocationLat = data[0]["projectSite"]['location']['lat'];
    projectSiteLocationLng = data[0]["projectSite"]['location']["lng"];
    print("Pick up site:::::${projectSiteLocationLat}");
    print("Pick up site:::::${projectSiteLocationLng}");
    processorSiteLocationLat = data[0]["processorSite"]['location']['lat'];
    processorSiteLocationLng = data[0]["processorSite"]['location']["lng"];

    await SharedPreference.addStringToSP(
        projectSiteLat, data[0]["projectSite"]['location']['lat']);
    await SharedPreference.addStringToSP(
        projectSiteLng, data[0]["projectSite"]['location']["lng"]);
    await SharedPreference.addStringToSP(
        processorSiteLat, data[0]["processorSite"]['location']['lat']);
    await SharedPreference.addStringToSP(
        processorSiteLng, data[0]["processorSite"]['location']["lng"]);
    var dropsite = await SharedPreference.getStringValueSP(processorSiteLat);
    var dropsitelng = await SharedPreference.getStringValueSP(processorSiteLng);
    var pickUpSite = await SharedPreference.getStringValueSP(projectSiteLat);
    var pickUpSitelng = await SharedPreference.getStringValueSP(projectSiteLng);
    print("pick up site:::::${pickUpSite}");
    print("pick up site:::::${pickUpSitelng}");
    return data;
  }

  Future<void> logout() async {
    final url =
        'https://clean-soil-rest-api-z8eug.ondigitalocean.app/api/v1/auth/user/logout'; // replace with your endpoint URL
    final response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      print("successfully logout ${response.body}");
      SharedPreference.clearDB();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => AccountSignInPage(),
          ),
          (route) => false);
    } else {
      // handle error
    }
  }

  @override
  void initState() {
    dashBoardactive();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 60,
            title: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                'Projects',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFPro'),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    Image.asset(
                      'images/notification.png',
                      height: 20,
                      width: 22,
                    ),
                    PopupMenuButton(
                        // add icon, by default "3 dot" icon
                        // icon: Icon(Icons.book)
                        itemBuilder: (context) {
                      return [
                        PopupMenuItem<int>(
                          child: TextButton(
                              onPressed: () {
                                logout();
                              },
                              child: Text("Logout")),
                        ),
                      ];
                    }),
                  ],
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size(50, 50),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                height: 32,
                decoration: BoxDecoration(
                    color: Color(0xff106EBE),
                    borderRadius: BorderRadius.circular(20)),
                child: TabBar(
                  labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'SFPro'),
                  indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  labelColor: Color(0xff0078D4),
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    Tab(
                      text: "Active",
                    ),
                    Tab(
                      text: 'All',
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: FutureBuilder(
              future: dashBoardactive(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else if (snapshot.data == null) {
                  return Text("No Data");
                }
                return TabBarView(
                  children: [
                    DashboardActive(
                      data: data,
                      projectSiteLocationLat:
                          double.parse(projectSiteLocationLat),
                      projectSiteLocationLng:
                          double.parse(projectSiteLocationLng),
                    ),
                    DashboardAll(
                      data: data,
                    )
                  ],
                );
              }),
          floatingActionButton: widget.userCompanyType == haulingCompany
              ? Column(
                  children: [
                    Spacer(),

                    // Navigate to pick-up site BUTTON
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white),
                            elevation: MaterialStatePropertyAll(0),
                            side: MaterialStatePropertyAll(
                                BorderSide(width: 1, color: Colors.grey))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomGoogleMaps(
                                  destinationLat:
                                      double.parse(projectSiteLocationLat),
                                  destinationLng:
                                      double.parse(projectSiteLocationLng),
                                ),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          width: 320,
                          height: 52,
                          child: Center(
                            child: Text(
                              "Navigate to pick-up site",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  fontFamily: "SFPro"),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 16,
                    ),

                    //Arrived at pick-up site BUTTON
                    ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStatePropertyAll(0),
                            side: MaterialStatePropertyAll(
                                BorderSide(width: 1, color: Colors.grey))),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomGoogleMaps(
                                  destinationLat:
                                      double.parse(processorSiteLocationLat),
                                  destinationLng:
                                      double.parse(processorSiteLocationLng),
                                ),
                              ));
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          width: 320,
                          height: 52,
                          child: Center(
                            child: Text(
                              "Navigate to drop site",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  fontFamily: "SFPro"),
                            ),
                          ),
                        ))
                  ],
                )
              : null,
        ),
      ),
    );
  }
}
