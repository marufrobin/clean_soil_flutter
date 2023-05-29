// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:flutter/material.dart';

import '../constans/constans.dart';
import '../model/shared_preference.dart';

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
  dynamic data;
  dynamic activeData;
  var projectSiteLocationLat;
  var projectSiteLocationLng;

  String? uId;

/*  Future dashBoardactive() async {
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
    print("data from active;;;;;;;;;;$data");
    return data;
  }*/

  @override
  void initState() {
    data = widget.data;
    print("Data from active: $data");
    getUserCompanyType();
    // dashBoardactive();

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
            itemBuilder: (context, index) {
              /*if (data.) {
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
                      ],
                    ));
              }*/
              return InkWell(
                onTap: () {
                  print(index);
                  /* Navigator.of(context).push(

                    MaterialPageRoute(
                        builder: ((context) => AllBatchPage(
                              projectId: data[index]["_id"],
                              projectName: data[index]["projectName"],
                              index: index,
                            ))),
                  );*/
                },
                child: Card(
                  elevation: 0.5,
                  child: ListTile(
                    title: Text(
                      "${data[index]["projectName"]}",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff212121),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SFPro'),
                    ),
                    subtitle: Text(
                      "${data[index]["projectName"]} to ${uCompanyType}",
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
            separatorBuilder: (_, index) => SizedBox(
                  height: 1,
                ),
            itemCount: data.length),
      ),
    );
  }
}
