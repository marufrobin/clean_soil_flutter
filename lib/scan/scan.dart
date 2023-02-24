// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:clean_soil_flutter/constans/constans.dart';
import 'package:clean_soil_flutter/construction_screen/allbatch.dart';
import 'package:clean_soil_flutter/model/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScan extends StatefulWidget {
  QrScan({required this.projectId, required this.projectName});
  var projectId;
  var projectName;
  @override
  State<StatefulWidget> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";

  dynamic data;
  Map<String, dynamic>? allBatch;
  var name;
  var userID;
  var userCompanyID;
  var role;
  var uCompanyType;
  getDriverUserInfo() async {
    name = await SharedPreference.getStringValueSP(userName);
    userID = await SharedPreference.getStringValueSP(userId);
    role = await SharedPreference.getStringValueSP(userPosition);
    uCompanyType = await SharedPreference.getStringValueSP(userCompanyType);

    print("userName :::: $name");
    print("User ID :::: $userID");
    print("User Role :::: $role");
    print("User Company Type :::: $uCompanyType");
    setState(() {});
  }

  var dataFromApi;
  Map<String, dynamic>? scanData;
  truckBatch({required String batchID}) async {
    var truckBatchUrl = "batch/accept-batch-by-truck?id=$batchID";
    var map = <String, dynamic>{"_id": userID, "fullName": name, "role": role};
    print("post Map ar kaj :::$map");
    var responce = await http.post(
        Uri.parse("$baseUrl$apiVersionUrl$truckBatchUrl"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(map));

    print("responce from post create${responce.statusCode}");
    print("responce from post create${responce.body}");
    var suc = jsonDecode(responce.body)["success"];
    var message = jsonDecode(responce.body)["message"];
    dataFromApi = jsonDecode(responce.body)["data"];
    print(suc);
    print("dataFromApi :::  $dataFromApi");
    if (responce.statusCode == 201 && suc == true) {
      scanData = {
        "id": dataFromApi["_id"],
        "createdAt": dataFromApi["created_at"],
        "picupTime": dataFromApi["pickUpTime"]
      };
      print("scan data:$scanData");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AllBatchPage(
            projectId: widget.projectId,
            projectName: widget.projectName,
            scanData: scanData,
          ),
        ),
      );
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

  @override
  void initState() {
    getDriverUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Color(0xff0078D4),
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
          "Scanner",
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontFamily: 'SFPro'),
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          truckBatch(batchID: "63f1ef9b7fb4229b4eb0524e");
        },
        child: Icon(
          Icons.send,
          color: Colors.black,
        ),
      ),*/
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 19, top: 19),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/scan_qr.png',
                          height: 18,
                          width: 18,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        if (result != null)
                          Text(
                              'Barcode Type: ${describeEnum(result!.format)} \nData: ${result!.code}')
                        else
                          Text(
                            "Scan QR code to accept batch",
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'SFPro'),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Facing any problem?',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff6E6E6E),
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFPro'),
                      ),
                      TextButton(
                        onPressed: (() {}),
                        child: Text(
                          'give us feedback',
                          style: TextStyle(
                              fontSize: 13,
                              color: Color(0xff0078D4),
                              fontWeight: FontWeight.w500,
                              fontFamily: 'SFPro'),
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
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 0,
          borderLength: 60,
          borderWidth: 3,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      print("scan idiididididi::::${result!.code}");
      print("scan idiididididi::::${result!.code}");
      result!.code != null ? truckBatch(batchID: result!.code!) : null;
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
