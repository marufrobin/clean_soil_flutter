// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unused_element, must_be_immutable, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:clean_soil_flutter/constans/constans.dart';
import 'package:clean_soil_flutter/model/shared_preference.dart';
import 'package:clean_soil_flutter/scan/scan.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AllBatchPage extends StatefulWidget {
  AllBatchPage({required this.projectId, required this.projectName});
  var projectId;
  var projectName;

  @override
  State<AllBatchPage> createState() => _AllBatchPageState(projectId: projectId);
}

class _AllBatchPageState extends State<AllBatchPage> {
  _AllBatchPageState({required this.projectId});
  TextEditingController approvedBy = TextEditingController();
  TextEditingController batchNo = TextEditingController();
  TextEditingController soilType = TextEditingController();
  TextEditingController materialQuantity = TextEditingController();

  final List position = [
    'project co-ordinator',
    'driver',
  ];

  String? selectedValue;

  final Map shippingStatus = {
    "dispatched": "images/dispatched.png",
    "shipped": "images/shipped.png",
    "waiting": "images/waiting.png",
  };

  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";
  var getAllBatchUrl = "batch/get-batchs?";
  var createBatchUrl = "batch/create-batch";
  var projectId;

  dynamic data;
  Map<String, dynamic>? allBatch;
  var Name;
  var userID;
  var userCompanyID;
  var role;
  Future getBatch() async {
    userID = await SharedPreference.getStringValueSP(userId);
    userCompanyID = await SharedPreference.getStringValueSP(usercompanyId);
    Name = await SharedPreference.getStringValueSP(userName);
    role = await SharedPreference.getStringValueSP(userPosition);
    var allBatchFullUrl =
        "$baseUrl$apiVersionUrl${getAllBatchUrl}projectId=$projectId";

    var responce = await http.get(
      Uri.parse(allBatchFullUrl),
      headers: {'Content-Type': 'application/json'},
    );
    allBatch = Map<String, dynamic>.from(jsonDecode(responce.body));
    data = allBatch!['data'];
    // print("data length :;;;;$data");
    return data;
  }

  createBatch() async {
    var map = <String, dynamic>{
      "projectId": "$projectId",
      "batchNumber": int.parse(batchNo.text),
      "approvedBy": {
        "_id": "$userCompanyID",
        "fullName": "$Name",
        "role": "$role"
      },
      "soilType": "${soilType.text.toString()}",
      "materialQuantity": "${materialQuantity.text.toString()}"
    };
    print("post Map ar kaj :::$map");
    var responce = await http.post(
        Uri.parse("$baseUrl$apiVersionUrl$createBatchUrl"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(map));

    print("responce from post create${responce.statusCode}");
    print("responce from post create${responce.body}");
    var suc = jsonDecode(responce.body)["success"];
    var message = jsonDecode(responce.body)["message"];
    var data = jsonDecode(responce.body)["data"];
    print(suc);
    print("maessageee:::$message");
    if (responce.statusCode == 201 && suc == true) {
      Fluttertoast.showToast(
          msg: "${message}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      setState(() {});
    }
  }

  var uCompanyType;
  getUserCompanyType() async {
    uCompanyType = await SharedPreference.getStringValueSP(userCompanyType);
    print("company type ::::$uCompanyType");
    setState(() {});
  }

  @override
  void initState() {
    getUserCompanyType();
    getBatch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _showModalBottomSheet() {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10.0),
            height: 600,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 36,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 120),
                    child: Text(
                      "Create Batch",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: "SFPro",
                          color: Color(0xff212121)),
                    ),
                  ),
                  trailing: IconButton(
                      onPressed: (() {
                        Navigator.pop(context);
                      }),
                      icon: Icon(
                        Icons.close,
                        size: 22,
                        color: Colors.grey,
                      )),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Batch no",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontFamily: "SFPro",
                                color: Color(0xff212121)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: batchNo,
                            decoration: InputDecoration(
                              hintText: "786",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontFamily: "SFPro",
                                color: Color(0xffACACAC),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE1E1E1)),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                        child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Approved by",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontFamily: "SFPro"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Maruf",
                              hintStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                fontFamily: "SFPro",
                                color: Color(0xffACACAC),
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xffE1E1E1)),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Soil type",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: "SFPro",
                      color: Color(0xff212121)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: soilType,
                  decoration: InputDecoration(
                    hintText: "Just Soil",
                    filled: true,
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: "SFPro",
                      color: Color(0xffACACAC),
                    ),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE1E1E1)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Material quantity",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: "SFPro",
                      color: Color(0xff212121)),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: materialQuantity,
                  decoration: InputDecoration(
                    filled: true,
                    labelStyle: TextStyle(color: Colors.black),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffE1E1E1)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    hintText: "Material quantity",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: "SFPro",
                      color: Color(0xffACACAC),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Spacer(),
                ElevatedButton(
                    style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                    onPressed: () {
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => QrScan()));
                      createBatch();
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      width: double.infinity,
                      height: 52,
                      child: Center(
                        child: Text(
                          "Create Batch",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              fontFamily: "SFPro"),
                        ),
                      ),
                    )),
              ],
            ),
          );
        },
      );
    }

    modalSheetForQRCodeShowing() {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10.0),
            height: 450,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 36,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(4)),
                  ),
                ),
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 116),
                    child: Text(
                      "Batch Code",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          fontFamily: "SFPro",
                          color: Color(0xff212121)),
                    ),
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: IconButton(
                        onPressed: (() {
                          Navigator.pop(context);
                        }),
                        icon: Icon(
                          Icons.close,
                          size: 20,
                          color: Colors.grey,
                        )),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                uCompanyType == haulingCompany
                    ? Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color(0xffF8F8F8),
                                borderRadius: BorderRadius.circular(4)),
                            margin: EdgeInsets.all(8),
                            height: 260,
                            width: 260,
                            child: QrImage(
                              gapless: true,
                              version: QrVersions.auto,
                              data: "${data![0]["_id"]}",
                              size: 200.0,
                            ),
                          ),
                        ],
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Color(0xffF8F8F8),
                            borderRadius: BorderRadius.circular(4)),
                        margin: EdgeInsets.all(8),
                        height: 260,
                        width: 260,
                        child: QrImage(
                          gapless: true,
                          version: QrVersions.auto,
                          data: "${data![0]["batchNumber"]}",
                          size: 200.0,
                        ),
                      )
              ],
            ),
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStatePropertyAll(0),
            ),
            onPressed: () {
              uCompanyType == haulingCompany
                  ? Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => QrScan()))
                  : _showModalBottomSheet();
            },
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              width: 320,
              height: 52,
              child: Center(
                child: Text(
                  uCompanyType == haulingCompany ? "Scan" : "Create Batch",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      fontFamily: "SFPro"),
                ),
              ),
            )),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.blue,
          leading: IconButton(
              onPressed: (() {
                Navigator.pop(context);
              }),
              icon: Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: Colors.white,
              )),
          title: Text(
            "${widget.projectName}",
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'SFPro'),
          ),
          actions: [
            IconButton(
                onPressed: (() {}),
                icon: Icon(
                  Icons.filter_list,
                  size: 20,
                  color: Colors.white,
                ))
          ],
        ),
        body: LiquidPullToRefresh(
          onRefresh: getBatch,
          child: FutureBuilder(
              future: getBatch(),
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

                return Container(
                  height: MediaQuery.of(context).size.height * 0.76,
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, _index) {
                        var status = data![_index]["status"].toString();
                        print("sssssssstasttt:::$status");
                        return SizedBox(
                          height: 176,
                          child: Row(
                            children: [
                              Expanded(
                                child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.transparent,
                                    child: status.toLowerCase() == "waiting"
                                        ? Image.asset(
                                            "${shippingStatus["waiting"]}")
                                        : status.toLowerCase() == "shipped"
                                            ? Image.asset(
                                                "${shippingStatus["shipped"]}")
                                            : Image.asset(
                                                "${shippingStatus["dispatched"]}")),
                              ),
                              Expanded(
                                flex: 4,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 1,
                                          color: Colors.black.withOpacity(0.2)),
                                      borderRadius: BorderRadius.circular(8)),
                                  elevation: 0.08,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              "${data[_index]["approvedBy"]["fullName"]}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'SFPro'),
                                            ),
                                            Text(
                                              "  →•  ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'SFPro'),
                                            ),
                                            Text(
                                              "${data[_index]["approvedBy"]["role"]}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'SFPro'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Batch:",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'SFPro'),
                                            ),
                                          ),
                                          Text(
                                            "${data![_index]["batchNumber"]}",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff212121),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'SFPro'),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Receiveed:",
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xff212121),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily: 'SFPro'),
                                                    ),
                                                  ),
                                                  Text(
                                                    "${Jiffy(data![_index]["created_at"]).format("h:mm a")}",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xff212121),
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily: 'SFPro'),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3),
                                                    color: Color(0xffEFF6FC)),
                                                child: Text(
                                                  "${data![_index]["status"]}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xff0078D4),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'SFPro'),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          GestureDetector(
                                            onTap: (() {
                                              modalSheetForQRCodeShowing();
                                            }),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color(0xffF8F8F8),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              margin: EdgeInsets.all(8),
                                              height: 80,
                                              width: 80,
                                              child: QrImage(
                                                gapless: true,
                                                version: QrVersions.auto,
                                                data: "${data![_index]["_id"]}",
                                                size: 200.0,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (_, index) => SizedBox(
                            height: 5,
                          ),
                      itemCount: data!.length),
                );
              }),
        ),
      ),
    );
  }
}
