// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
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
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          Stack(
            children: [
              Expanded(flex: 4, child: _buildQrView(context)),
              Positioned(
                  top: 24,
                  left: 100,
                  child: Container(
                    height: 32,
                    width: 189,
                    decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "Point towards QR code",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'SFPro'),
                      ),
                    ),
                  ))
            ],
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 19, top: 19),
              child: Column(
                children: [
                  Container(
                    child: Row(
                      children: [
                        Image.asset(
                          'images/scan_qr.png',
                          height: 18,
                          width: 18,
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        if (result != null)
                          Text(
                              'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
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
                    height: 34,
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
                      Text(
                        'give us feedback',
                        style: TextStyle(
                            fontSize: 13,
                            color: Color(0xff0078D4),
                            fontWeight: FontWeight.w500,
                            fontFamily: 'SFPro'),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // child: FittedBox(
            //   fit: BoxFit.contain,
            //   child: Column(
            //     // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: <Widget>[
            //       // if (result != null)
            //       //   Text(
            //       //       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
            //       // else
            //       //   const Text('Scan a code'),

            //     ],
            //   ),
            // ),
            // child: Padding(
            //   padding: const EdgeInsets.only(left: 19, top: 19),
            //   child: Row(
            //     children: [
            //       Image.asset(
            //         'images/scan_qr.png',
            //         height: 20,
            //         width: 22,
            //       ),
            //       Text(
            //         "Scan QR code to accept batch",
            //         style: TextStyle(
            //             fontSize: 17,
            //             color: Colors.black,
            //             fontWeight: FontWeight.w400,
            //             fontFamily: 'SFPro'),
            //       ),
            //     ],
            //   ),
            // ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 250.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 0,
          borderLength: 60,
          borderWidth: 2,
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
