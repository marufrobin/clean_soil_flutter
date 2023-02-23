// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:developer';

import 'package:clean_soil_flutter/constans/constans.dart';
import 'package:clean_soil_flutter/model/shared_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";
  var truckBatchUrl =
      "accept-batch-by-truck?id=%20%22e65vgf65trvtyf65cgvyttctgt6776%22";

  dynamic data;
  Map<String, dynamic>? allBatch;
  var Name;
  var userID;
  var userCompanyID;
  var role;

  truckBatch() async {
    var map = <String, dynamic>{
      "_id": "$userCompanyID",
      "fullName": "$Name",
      "role": "$role"
    };
    print("post Map ar kaj :::$map");
    var responce = await http.post(
        Uri.parse("$baseUrl$apiVersionUrl$truckBatchUrl"),
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
  }

  @override
  void initState() {
    getUserCompanyType();
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
                              'Barcode Type: ${describeEnum(data![0]["id"].format)}   Data: ${data![0]["id"].code}')
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
          )
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
