// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, unused_element, must_be_immutable, prefer_const_constructors_in_immutables

import 'dart:convert';

import 'package:clean_soil_flutter/constans/constans.dart';
import 'package:clean_soil_flutter/model/shared_preference.dart';
import 'package:clean_soil_flutter/scanner/qr_scanner.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:jiffy/jiffy.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../google_map/customGoogleMaps.dart';
// import '../scan/scan.dart';

class AllBatchPage extends StatefulWidget {
  AllBatchPage(
      {required this.projectId,
      required this.projectName,
      this.scanData,
      this.index});
  var projectId;
  var projectName;
  var index;
  Map? scanData;

  @override
  State<AllBatchPage> createState() => _AllBatchPageState();
}

class _AllBatchPageState extends State<AllBatchPage> {
  // _AllBatchPageState({required this.projectId});
  TextEditingController approvedBy = TextEditingController();
  TextEditingController batchNo = TextEditingController();
  TextEditingController soilType = TextEditingController();
  TextEditingController materialQuantity = TextEditingController();
  TextEditingController truckNo = TextEditingController();
  TextEditingController licenceNo = TextEditingController();
  /* TextEditingController prossecorCompany = TextEditingController();*/
  TextEditingController haularCompany = TextEditingController();
  // ,Truck no,  licence no, prossecor company,  haular company

  final List position = [
    'project co-ordinator',
    'driver',
  ];
  final List<String> prossecorCompanyList = ['select None'];

  final List<String> pickupSitesList = ['select None'];
  final List<String> dropSitesList = ['select None'];
  String? selectedValue;
  int? selectIndexValueForPickupSites;
  int? selectIndexValueForDropSites;
  int? selectIndexValueForHPro;
  String? selectedProssecorCompany;
  String? selectedPickupSite;
  String? selectedDropSite;

  final Map shippingStatus = {
    "dispatched": "images/dispatched.png",
    "shipped": "images/shipped.png",
    "waiting": "images/waiting.png",
  };

  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";
  var getAllBatchUrl = "batch/get-batchs?";
  var createBatchUrl = "batch/create-batch";
  var DashBoadactiveUrl = "project/get-assigned-projects-by-user";
  var projectId;

  dynamic data;
  Map<String, dynamic>? allBatch;
  var Name;
  var userID;
  var userCompanyID;
  var role;
  String? uId;
  String? uCompanyType;
  var allData;
  bool isLoading = false;
  Future gettingCompanyList() async {
    setState(() {
      isLoading = true;
    });
    uId = await SharedPreference.getStringValueSP(userId);
    uCompanyType = await SharedPreference.getStringValueSP(userCompanyType);

    var DashBoardallUrl =
        "$baseUrl$apiVersionUrl$DashBoadactiveUrl?userId=$uId&userCompanyType=$uCompanyType";
    print("DashBoard URL::::: $DashBoardallUrl");
    var responce = await http.get(
      Uri.parse(DashBoardallUrl),
      headers: {'Content-Type': 'application/json'},
    );
    allData = jsonDecode(responce.body);
    print("Get the All the ::${allData}");

    print("index number :$index");
    print("Get the reponce ::${allData["data"][index]["processorCompanies"]}");
    allprocessorCompanies = allData["data"][index]["processorCompanies"];
    // List listValue = allhaulerCompany
    print("company length :: ${allprocessorCompanies!.length.toString()}");
    for (int i = 0; i < allprocessorCompanies!.length; i++) {
      prossecorCompanyList.add(allprocessorCompanies[i]['name']);
      print("name of the company::${allprocessorCompanies[i]['name']} ");
    }
    print("company name List:: $prossecorCompanyList");

    projectSites = allData["data"][index]["projectSites"];
    // List listValue = allhaulerCompany
    print("company length :: ${projectSites!.length.toString()}");
    for (int i = 0; i < projectSites!.length; i++) {
      pickupSitesList.add(projectSites[i]['siteName']);
      print("name of the company::${projectSites[i]['siteName']} ");
    }
    dropOffSites = allData["data"][index]["dropOffSites"];
    // List listValue = allhaulerCompany
    print("company length :: ${dropOffSites!.length.toString()}");
    for (int i = 0; i < dropOffSites!.length; i++) {
      dropSitesList.add(dropOffSites[i]['siteName']);
      print("name of the company::${dropOffSites[i]['siteName']} ");
    }
    setState(() {
      isLoading = false;
    });
    print("company name List:: $pickupSitesList");
  }

  final List<String> newList = [];
  dynamic projectSites;
  dynamic dropOffSites;
  dynamic allprocessorCompanies;
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
    // setState(() {});
    print("data length :;;;;$data");
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
      "soilType": soilType.text.toString(),
      "materialQuantity": materialQuantity.text.toString(),
      "pickupAndDropedBy": {
        "truckNo": truckNo.text,
        "licenceNo": licenceNo.text
      },
      "pickupSite": {
        "location": {
          "lat": allData["data"][index]["projectSites"]
              [selectIndexValueForPickupSites! - 1]["location"]["lat"],
          "lng": allData["data"][index]["projectSites"]
              [selectIndexValueForPickupSites! - 1]["location"]["lng"]
        },
        "address": allData["data"][index]["projectSites"]
            [selectIndexValueForPickupSites! - 1]["address"],
        "siteName": allData["data"][index]["projectSites"]
            [selectIndexValueForPickupSites! - 1]["siteName"]
      },
      "dropOffSite": {
        "siteName": allData["data"][index]["dropOffSites"]
            [selectIndexValueForDropSites! - 1]["siteName"],
        "address": allData["data"][index]["dropOffSites"]
            [selectIndexValueForDropSites! - 1]["address"],
        "location": {
          "lat": allData["data"][index]["dropOffSites"]
              [selectIndexValueForDropSites! - 1]["location"]["lat"],
          "lng": allData["data"][index]["dropOffSites"]
              [selectIndexValueForDropSites! - 1]["location"]["lng"]
        }
      },
      "processorCompany": {
        "location": allData["data"][index]["processorCompanies"]
            [selectIndexValueForHPro! - 1]["location"],
        "isAccepted": true,
        "_id": allData["data"][index]["processorCompanies"]
            [selectIndexValueForHPro! - 1]["_id"],
        "name": allData["data"][index]["processorCompanies"]
            [selectIndexValueForHPro! - 1]["name"],
        "address": allData["data"][index]["processorCompanies"]
            [selectIndexValueForHPro! - 1]["address"]
      },
      "haulerCompany": {
        "name": haularCompany.text.toString(),
      }
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
    // var data = jsonDecode(responce.body)["data"];
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

  getUserCompanyType() async {
    uCompanyType = await SharedPreference.getStringValueSP(userCompanyType);
    print("company type ::::$uCompanyType");
    setState(() {});
  }

  var index;
  @override
  void initState() {
    projectId = widget.projectId;
    index = widget.index;
    getUserCompanyType();

    getBatch();
    gettingCompanyList();
    widget.scanData != null
        ? WidgetsBinding.instance.addPostFrameCallback((_) {
            modelSheetForScanData(context);
          })
        : null;
    getNavOfDropSite();
    super.initState();
  }

  String? dropSiteLat;
  String? dropSiteLng;
  String? pickUpLat;
  String? pickUpLng;

  getNavOfDropSite() async {
    dropSiteLat = await SharedPreference.getStringValueSP(processorSiteLat);
    dropSiteLng = await SharedPreference.getStringValueSP(processorSiteLng);
    pickUpLat = await SharedPreference.getStringValueSP(projectSiteLat);
    pickUpLng = await SharedPreference.getStringValueSP(projectSiteLng);
    print("pickUp Site: $pickUpLat,  $pickUpLng");
  }

  modelSheetForScanData(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(10.0),
          height: MediaQuery.of(context).size.height * 0.66,
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
                    "Batch details",
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
              Container(
                child: Text(
                  "Pick-Up: ${Jiffy(widget.scanData!["createdAt"]).format('MMMM do yyyy, h:mm a')}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: "SFPro",
                      color: Colors.grey.shade500),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Text(
                  "Drop: ${widget.scanData!["picupTime"]}",
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      fontFamily: "SFPro",
                      color: Colors.grey.shade500),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(4)),
                  margin: EdgeInsets.all(8),
                  height: 260,
                  width: 260,
                  child: QrImage(
                    gapless: true,
                    version: QrVersions.auto,
                    data: "${widget.scanData!["id"]}",
                    size: 200.0,
                  ),
                ),
              ),
              /*Spacer(),
                ElevatedButton(
                    style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.only(left: 16, right: 16),
                      width: double.infinity,
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
                    )),*/
            ],
          ),
        );
      },
    );
  }

  Future getRefresh() async {
    setState(() async {
      getUserCompanyType();
      prossecorCompanyList.clear();
      pickupSitesList.clear();
      dropSitesList.clear();
      prossecorCompanyList.add('select None');

      pickupSitesList.add('select None');
      dropSitesList.add('select None');
      await getBatch();
      gettingCompanyList();
      widget.scanData != null
          ? WidgetsBinding.instance.addPostFrameCallback((_) {
              modelSheetForScanData(context);
            })
          : null;
      getNavOfDropSite();
    });
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
          builder: (BuildContext context) => StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.86,
                  child: Scaffold(
                    appBar: AppBar(
                      surfaceTintColor: Colors.transparent,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      leading: Container(),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          SizedBox(height: 16),
                          Text(
                            "Create Batch",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                fontFamily: "SFPro",
                                color: Color(0xff212121)),
                          ),
                        ],
                      ),
                      actions: [
                        IconButton(
                            onPressed: (() {
                              Navigator.pop(context);
                            }),
                            icon: Icon(
                              Icons.close,
                              size: 22,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                    body: Container(
                      padding: EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Batch No
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
                                        keyboardType: TextInputType.number,
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
                                            borderSide: BorderSide(
                                                color: Color(0xffE1E1E1)),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                  child: Text(
                                    "Approved by \n$Name",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        fontFamily: "SFPro"),
                                  ),
                                  /*child: Column(
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
                                            borderSide: BorderSide(
                                                color: Color(0xffE1E1E1)),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),*/
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //soil type
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
                                  borderSide:
                                      BorderSide(color: Color(0xffE1E1E1)),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            //Material quantity
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
                                  borderSide:
                                      BorderSide(color: Color(0xffE1E1E1)),
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
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      //Truck No
                                      Text(
                                        "Truck No",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "SFPro",
                                            color: Color(0xff212121)),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
//Truck No
                                      TextField(
                                        controller: truckNo,
                                        decoration: InputDecoration(
                                          hintText: "78",
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "SFPro",
                                            color: Color(0xffACACAC),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffE1E1E1)),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "licence No",
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
                                          hintText: "eb07",
                                          hintStyle: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            fontFamily: "SFPro",
                                            color: Color(0xffACACAC),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(0xffE1E1E1)),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
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
                              "Select hauler Company",
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
                              controller: haularCompany,
                              decoration: InputDecoration(
                                filled: true,
                                labelStyle: TextStyle(color: Colors.black),
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Color(0xffE1E1E1)),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                hintText: "Hauler company",
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
                            //prossecor company,
                            Text(
                              "Select Prossecor Company",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: "SFPro",
                                  color: Color(0xff212121)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(
                                    'Select Item',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: prossecorCompanyList
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedProssecorCompany,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedProssecorCompany =
                                          value as String;
                                      for (int i = 0;
                                          i < prossecorCompanyList.length;
                                          i++) {
                                        if (selectedProssecorCompany ==
                                            prossecorCompanyList[i]) {
                                          selectIndexValueForHPro = i;
                                          print(
                                              "select value Index: $selectIndexValueForHPro");
                                        }
                                      }
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // haular company
                            Text(
                              "Select pickup site",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: "SFPro",
                                  color: Color(0xff212121)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(
                                    'Select pickup sites',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: pickupSitesList
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedPickupSite,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPickupSite = value as String;

                                      for (int i = 0;
                                          i < pickupSitesList.length;
                                          i++) {
                                        if (selectedPickupSite ==
                                            pickupSitesList[i]) {
                                          selectIndexValueForPickupSites = i;
                                          print(
                                              "select value Iindex: $selectIndexValueForPickupSites");
                                        }
                                      }
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Select Drop site",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: "SFPro",
                                  color: Color(0xff212121)),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              height: 60,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              width: double.infinity,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Text(
                                    'Select Drop sites',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: dropSitesList
                                      .map((item) => DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedDropSite,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedDropSite = value as String;

                                      for (int i = 0;
                                          i < dropSitesList.length;
                                          i++) {
                                        if (selectedDropSite ==
                                            dropSitesList[i]) {
                                          selectIndexValueForDropSites = i;
                                          print(
                                              "select value from drop site: $selectIndexValueForDropSites");
                                        }
                                      }
                                    });
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                    elevation: MaterialStatePropertyAll(0)),
                                onPressed: () async {
                                  // Navigator.of(context).push(
                                  //     MaterialPageRoute(builder: (context) => QrScan()));
                                  await createBatch();
                                  Navigator.pop(context);
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
                      ),
                    ),
                  ),
                );
              }));
    }

    modalSheetForQRCodeShowing(String qrCodeImage) {
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
                          data: qrCodeImage,
                          size: 200.0,
                        ),
                      )
              ],
            ),
          );
        },
      );
    }

    batchDetailsInfoModalSheet({required int index}) {
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10.0),
            height: MediaQuery.of(context).size.height * 0.4,
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
                      "Batch details",
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
                Container(
                  child: Text(
                    "Pick-Up: ${Jiffy(data[index]["createdAt"]).format('MMMM do yyyy, h:mm a')}",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: "SFPro",
                        color: Colors.grey.shade500),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  child: Text(
                    "Drop: ${data[index]["pickUpTime"]}",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        fontFamily: "SFPro",
                        color: Colors.grey.shade500),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Spacer(),
                uCompanyType == haulingCompany
                    ? ElevatedButton(
                        style:
                            ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                        onPressed: () {
                          if (data![index]["status"].toString().toLowerCase() ==
                              "waiting") {
                            print("dropsitee ::: ${dropSiteLat} $dropSiteLng");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomGoogleMaps(
                                    destinationLat: double.parse(dropSiteLat!),
                                    destinationLng: double.parse(dropSiteLng!),
                                  ),
                                ));
                          } else {
                            print("Navigate to Pick Up site");
                            print("PickUp site::: ${pickUpLat} $pickUpLng");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CustomGoogleMaps(
                                    destinationLat: double.parse(pickUpLat!),
                                    destinationLng: double.parse(pickUpLng!),
                                  ),
                                ));
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          width: double.infinity,
                          height: 52,
                          child: Center(
                            child: Text(
                              data![index]["status"].toString().toLowerCase() ==
                                      "waiting"
                                  ? "Navigate to drop site"
                                  : "Navigate to Pick Up site",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  fontFamily: "SFPro"),
                            ),
                          ),
                        ))
                    : Text(""),
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
              uCompanyType != constructionCompany
                  ? Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => QRViewExample(),
                    ))
                  : _showModalBottomSheet();
              // modelSheetForScanData();
            },
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              width: 320,
              height: 52,
              child: Center(
                child: Text(
                  uCompanyType != constructionCompany
                      ? "Scan code"
                      : "Create Batch",
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
                onPressed: (() {
                  // gettingCompanyList();
                  setState(() {
                    // getBatch();
                    gettingCompanyList();
                  });
                }),
                icon: isLoading
                    ? Container(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ))
                    : Icon(
                        Icons.refresh_rounded,
                        size: 20,
                        color: Colors.white,
                      ))
          ],
        ),
        body: LiquidPullToRefresh(
          onRefresh: getRefresh,
          child: FutureBuilder(
              future: getBatch(),
              builder: (context, snapshot) {
                print(snapshot.data);
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
                                child: GestureDetector(
                                  onTap: () {
                                    batchDetailsInfoModalSheet(index: _index);
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1,
                                            color:
                                                Colors.black.withOpacity(0.2)),
                                        borderRadius: BorderRadius.circular(8)),
                                    elevation: 0.08,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: FittedBox(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "${data[_index]["approvedBy"]["fullName"]}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SFPro'),
                                                ),
                                                Text(
                                                  "  →•  ",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SFPro'),
                                                ),
                                                Text(
                                                  "${data[_index]["approvedBy"]["role"]}",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontFamily: 'SFPro'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                            color: Color(
                                                                0xff212121),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'SFPro'),
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
                                                        color:
                                                            Color(0xff0078D4),
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
                                                modalSheetForQRCodeShowing(
                                                    "${data![_index]["_id"]}");
                                              }),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xffF8F8F8),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                margin: EdgeInsets.all(8),
                                                height: 80,
                                                width: 80,
                                                child: QrImage(
                                                  gapless: true,
                                                  version: QrVersions.auto,
                                                  data:
                                                      "${data![_index]["_id"]}",
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
