// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AllBatchPage extends StatelessWidget {
  const AllBatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ElevatedButton(
            style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
            onPressed: () {},
            child: Container(
              width: 320,
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
        appBar: AppBar(
          toolbarHeight: 71,
          backgroundColor: Colors.blue,
          leading: Container(
              padding: EdgeInsets.only(top: 26, bottom: 10),
              child: IconButton(
                  onPressed: (() {}),
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    color: Colors.white,
                  ))),
          title: Container(
            padding: EdgeInsets.only(left: 51, top: 26, bottom: 10),
            child: Text(
              "Lafarge worksite",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SFPro'),
            ),
          ),
          actions: [
            Container(
                padding: EdgeInsets.only(right: 10, top: 26, bottom: 10),
                child: IconButton(
                    onPressed: (() {}),
                    icon: Icon(
                      Icons.settings,
                      size: 25,
                      color: Colors.white,
                    )))
          ],
        ),
        body: Container(
          child: ListView.separated(
              itemBuilder: (_index, context) => Container(
                    height: 190,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Lafarge worksite Proccessor",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'SFPro'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Batch:786",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'SFPro'),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Receiveed:9:30 AM",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'SFPro'),
                            ),
                          ),
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: (() {}),
                                  child: Text(
                                    "Shipped",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'SFPro'),
                                  )),
                              Container(
                                height: 75,
                                width: 75,
                                child: QrImage(
                                  gapless: true,
                                  version: QrVersions.auto,
                                  data: "Maruf",
                                  size: 200.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
              separatorBuilder: (_, index) => SizedBox(
                    height: 5,
                  ),
              itemCount: 10),
        ),
      ),
    );
  }
}
