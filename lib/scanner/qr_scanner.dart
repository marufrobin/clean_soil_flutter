import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:clean_soil_flutter/construction_screen/dashboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:google_maps_demo/customHTTP.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../constans/constans.dart';
import '../model/shared_preference.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  var baseUrl = "https://clean-soil-rest-api-z8eug.ondigitalocean.app/";
  var apiVersionUrl = "api/v1/";

  acceptBatchByScan({required String batchId}) async {
    var acceptByProccessor = "batch/accept-batch-by-processor?id=$batchId";

    String processorUserId = await SharedPreference.getStringValueSP(userId);
    String processorUserName =
        await SharedPreference.getStringValueSP(userName);
    String processorUserPosition =
        await SharedPreference.getStringValueSP(userPosition);
    String processorUserCompanyType =
        await SharedPreference.getStringValueSP(userCompanyType);
    Map<String, dynamic> bodyMap = {
      "_id": processorUserId,
      "fullName": processorUserName,
      "role": processorUserPosition
    };
    var response = await http.post(
        Uri.parse("$baseUrl$apiVersionUrl$acceptByProccessor"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(bodyMap));
    print("printinnnngnng mapppppppp: $bodyMap");
    print("Resspoceeeeeeeeeeeeee from api:::${response.body}");
    var suc = jsonDecode(response.body)["success"];
    var data = jsonDecode(response.body)["data"];
    print(suc);
    if (response.statusCode == 201 && suc == true) {
      Fluttertoast.showToast(
          msg: "${jsonDecode(response.body)["message"]}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) =>
                DashboardScreen(userCompanyType: processorUserCompanyType),
          ),
          (route) => false);
    } else {
      Fluttertoast.showToast(
          msg: "${jsonDecode(response.body)["message"]}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller != null && mounted) {
      controller!.pauseCamera();
      controller!.resumeCamera();
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 2, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    result != null
                        ? Text(
                            'Barcode Type: ${describeEnum(result!.format)}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          )
                        : const Text('Barcode Type:'),
                    result != null
                        ? Text(
                            'Batch id: ${result!.code}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.orange),
                          )
                        : Text(''),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          elevation: 0, fixedSize: Size(200, 40)),
                      onPressed: () {
                        setState(() {
                          acceptBatchByScan(batchId: result!.code!);
                          // CustomHttp.fetchdata(result!.code, context);
                        });
                      },
                      child:
                          const Text("Accept", style: TextStyle(fontSize: 20)),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          result = null;
                        });
                      },
                      child: Text(
                        "Scan again",
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 350.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
