// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, avoid_print

import 'package:clean_soil_flutter/construction_screen/allbatch.dart';
import 'package:flutter/material.dart';

class DashboardActive extends StatefulWidget {
  List data;
  DashboardActive({super.key, required this.data});

  @override
  State<DashboardActive> createState() => _DashboardActiveState();
}

class _DashboardActiveState extends State<DashboardActive> {
  /*var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";
  var DashBoadactiveUrl = "project/get-assigned-projects-by-user";
  String userId = "63dbe295137a82239e717ab9";
  String userCompanyType = "construction";
  Map<String, dynamic>? allData;
  List? data;
  Future dashBoardactive() async {
    var DashBoardallUrl =
        "$baseUrl$apiVersionUrl$DashBoadactiveUrl?userId=$userId&userCompanyType=$userCompanyType";

    var responce = await http.get(
      Uri.parse(DashBoardallUrl),
      headers: {'Content-Type': 'application/json'},
    );

    // var dashboadall = await http.get(Uri.parse(DashBoardallUrl));
    allData = Map<String, dynamic>.from(jsonDecode(responce.body));
    data = allData!["data"];
    // print("all data from api ::::projec ::::${allData}");
    for (int index = 0; index <= data!.length; index++) {
      print("data from api ::::projec ::::${data![index]["_id"]}");
    }
    print("data from api ::::project id oneeeee ::::${data![0]["_id"]}");
    // return data;
    setState(() {});
  }*/

  @override
  void initState() {
    super.initState();
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
