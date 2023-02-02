// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:clean_soil_flutter/construction_screen/dashboard_active.dart';
import 'package:clean_soil_flutter/construction_screen/dashboard_all.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: Padding(
              padding: const EdgeInsets.only(top: 19.2, left: 16),
              child: Text(
                'Projects',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'SFPro'),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 19.2, right: 20),
                child: Image.asset(
                  'images/notification.png',
                  height: 20.01,
                  width: 22,
                ),
              )
            ],
            bottom: PreferredSize(
              preferredSize: Size(50, 50),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                height: 32,
                decoration: BoxDecoration(
                    color: Color(0xff106EBE),
                    borderRadius: BorderRadius.circular(20)),
                child: TabBar(
                  indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0)),
                  labelColor: Color(0xff0078D4),
                  unselectedLabelColor: Colors.black,
                  tabs: const [
                    Tab(
                      text: 'Active',
                    ),
                    Tab(
                      text: 'All',
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [DashboardActive(), DashboardAll()],
          ),
        ),
      ),
    );
  }
}
