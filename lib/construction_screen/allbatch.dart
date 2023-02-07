// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:clean_soil_flutter/scan/scan.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AllBatchPage extends StatelessWidget {
  AllBatchPage({super.key});
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

  @override
  Widget build(BuildContext context) {
    _showModalBottomSheet() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10.0),
            height: 600,
            color: Colors.white,
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
                          fontFamily: "SFPro"),
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
                                fontFamily: "SFPro"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: batchNo,
                            decoration: InputDecoration(
                              hintText: "786",
                              filled: true,
                              labelStyle: TextStyle(color: Colors.black),
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
                            controller: batchNo,
                            decoration: InputDecoration(
                              hintText: "Jane Doe",
                              filled: true,
                              labelStyle: TextStyle(color: Colors.black),
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
                      fontFamily: "SFPro"),
                ),
                SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: approvedBy,
                  decoration: InputDecoration(
                    labelText: "Just Soil",
                    filled: true,
                    labelStyle: TextStyle(color: Colors.black),
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
                      fontFamily: "SFPro"),
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
                    labelText: "Material quantity",
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Receiving site",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      fontFamily: "SFPro"),
                ),
                SizedBox(
                  height: 10,
                ),
                DropdownButtonFormField2(
                  decoration: InputDecoration(
                    //Add isDense true and zero Padding.
                    //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    //Add more decoration as you want here
                    //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                  ),
                  isExpanded: true,
                  hint: const Text(
                    'Select',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Color(0xff0086F0),
                        fontFamily: "SFPro"),
                  ),
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black45,
                  ),
                  iconSize: 30,
                  buttonHeight: 60,
                  buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                  dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  items: position
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
                  validator: (value) {
                    if (value == null) {
                      return 'Please select Your Position';
                    }
                  },
                  onChanged: (value) {
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                ),
                Spacer(),
                ElevatedButton(
                    style: ButtonStyle(elevation: MaterialStatePropertyAll(0)),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => QrScan()));
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
              width: 320,
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
                    height: 176,
                    child: Row(
                      children: [
                        Expanded(
                            child: CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.transparent,
                          child: Image.asset(
                            "${shippingStatus["dispatched"]}",
                          ),
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
                                        "  →•  ",
                                        style: TextStyle(
                                            fontSize: 18,
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
