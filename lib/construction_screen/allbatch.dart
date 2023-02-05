// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AllBatchPage extends StatelessWidget {
  AllBatchPage({super.key});
  TextEditingController approvedBy = TextEditingController();
  TextEditingController batchNo = TextEditingController();
  TextEditingController soilType = TextEditingController();
  TextEditingController materialQuantity = TextEditingController();
  TextEditingController receivingSite = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _showModalBottomSheet() {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10),
            height: 500,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  child: Center(
                    child: QrImage(
                      gapless: true,
                      version: QrVersions.auto,
                      data: "Maruf",
                      size: 200.0,
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                    style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                    onPressed: () {
                      _showModalBottomSheet();
                    },
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
              _showModalBottomSheet();
            },
            child: Container(
              width: 340,
              height: 52,
              child: Center(
                child: Text(
                  "Create Batch",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
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
            "Lafarge worksite",
            style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontFamily: 'SFPro'),
          ),
          actions: [
            IconButton(
                onPressed: (() {
                  _showModalBottomSheet();
                }),
                icon: Icon(
                  Icons.filter_list,
                  size: 20,
                  color: Colors.white,
                ))
          ],
        ),
        body: Container(
          child: ListView.separated(
              itemBuilder: (_index, context) => SizedBox(
                    height: 172,
                    child: Row(
                      children: [
                        Expanded(
                            child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.blue,
                        )),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "Lafarge worksite",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'SFPro'),
                                      ),
                                      Text(
                                        "→•",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'SFPro'),
                                      ),
                                      Text(
                                        "Proccessor",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'SFPro'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Batch:786",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'SFPro'),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Receiveed:9:30 AM",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'SFPro'),
                                          ),
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
                                                  BorderRadius.circular(3),
                                              color: Color(0xffEFF6FC)),
                                          child: Text(
                                            "Shipped",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xff0078D4),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: 'SFPro'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Container(
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
                                        data: "Maruf",
                                        size: 200.0,
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
