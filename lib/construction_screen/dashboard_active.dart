// ignore_for_file: prefer_const_constructors

import 'package:clean_soil_flutter/construction_screen/activebatch.dart';
import 'package:flutter/material.dart';

class DashboardActive extends StatefulWidget {
  const DashboardActive({super.key});

  @override
  State<DashboardActive> createState() => _DashboardActiveState();
}

class _DashboardActiveState extends State<DashboardActive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.separated(
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => ActiveBatchPage())));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                        "Lafarge Worksite",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SFPro'),
                      ),
                      subtitle: Text(
                        "Lafarge worksite to processer",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'SFPro'),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 20,
                      ),
                    ),
                  ),
                ),
            separatorBuilder: (_, index) => SizedBox(
                  height: 1,
                ),
            itemCount: 3),
      ),
    );
  }
}
