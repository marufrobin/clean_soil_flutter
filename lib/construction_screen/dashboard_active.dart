// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'dart:convert';

import 'package:clean_soil_flutter/construction_screen/activebatch.dart';
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
  String userId = "63dbe295137a82239e717ab9";
  String userCompanyType = "construction";

  dashBoardactic() async {
    var DashBoadactiveUrl = "project/get-assigned-projects-by-user";

    var responce = await http.get(
      Uri.parse(
          "$baseUrl$apiVersionUrl$DashBoadactiveUrl?userId=$userId&userCompanyType=$userCompanyType"),
      headers: {'Content-Type': 'application/json'},
    );

    print("Resspoceeeeeeeeeeeeee from api:::${responce}");
    var suc = jsonDecode(responce.body);
    print("api response with body:$suc");
    // if (responce.statusCode == 200 && suc == true) {
    // } else {
    //   Fluttertoast.showToast(
    //       msg: "${jsonDecode(responce.body)["message"]}",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.red,
    //       textColor: Colors.white,
    //       fontSize: 16.0);
    // }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dashBoardactic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => ActiveBatchPage())));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "Lafarge Worksite",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SFPro'),
                      ),
                      subtitle: Text(
                        "Lafarge worksite to processer",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SFPro'),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                  ),
                ),
            separatorBuilder: (_, index) => SizedBox(
                  height: 1,
                ),
            itemCount: 3),
      ),
    );
  }
}
