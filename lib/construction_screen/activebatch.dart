// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ActiveBatchPage extends StatefulWidget {
  const ActiveBatchPage({super.key});

  @override
  State<ActiveBatchPage> createState() => _ActiveBatchPageState();
}

class _ActiveBatchPageState extends State<ActiveBatchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: ElevatedButton(
            style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
            onPressed: () {},
            child: Container(
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
        appBar: AppBar(
          toolbarHeight: 71,
          backgroundColor: Colors.blue,
          leading: Container(
            padding: EdgeInsets.only(top: 26, bottom: 10),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
          ),
          title: Container(
            padding: EdgeInsets.only(left: 51, top: 26, bottom: 10),
            child: Text(
              "Lafarge worksite",
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'SFPro'),
            ),
          ),
          actions: [
            Container(
              padding: EdgeInsets.only(right: 10, top: 26, bottom: 10),
              child: Icon(
                Icons.settings,
                size: 20,
                color: Colors.white,
              ),
            )
          ],
        ),
        body: Container(
          child: ListView.separated(
              itemBuilder: (_index, context) => Container(
                    height: 200,
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
                          SizedBox(
                            height: 5,
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
                          SizedBox(
                            height: 5,
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
                                height: 50,
                                width: 50,
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
              itemCount: 3),
        ),
      ),
    );
  }
}
