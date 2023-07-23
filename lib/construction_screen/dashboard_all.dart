// ignore_for_file: prefer_const_constructors

import 'package:clean_soil_flutter/constans/constans.dart';
import 'package:clean_soil_flutter/model/shared_preference.dart';
import 'package:flutter/material.dart';

import 'allbatch.dart';

class DashboardAll extends StatefulWidget {
  var data;
  DashboardAll({super.key, required this.data});

  @override
  State<DashboardAll> createState() => _DashboardAllState();
}

class _DashboardAllState extends State<DashboardAll> {
  var uCompanyType;
  getUserCompanyType() async {
    uCompanyType = await SharedPreference.getStringValueSP(userCompanyType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.data == null || widget.data == []
          ? Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(),
                  Icon(Icons.warning, size: 50, color: Colors.amber),
                  SizedBox(height: 20),
                  Text(
                    "No project has been assigned",
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ))
          : ListView.separated(
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      print(index);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AllBatchPage(
                                projectId: widget.data[index]["_id"],
                                projectName: widget.data[index]["projectName"],
                                index: index,
                              )));
                    },
                    child: Card(
                      elevation: 0.5,
                      child: ListTile(
                        title: Text(
                          "${widget.data[index]["projectName"]}",
                          style: TextStyle(
                              fontSize: 14,
                              color: Color(0xff212121),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'SFPro'),
                        ),
                        subtitle: Text(
                          "${widget.data[index]["projectName"]} to ${uCompanyType} ",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff6E6E6E),
                              fontWeight: FontWeight.w400,
                              fontFamily: 'SFPro'),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
              separatorBuilder: (_, index) => SizedBox(
                    height: 1,
                  ),
              itemCount: widget.data.length),
    );
  }
}
