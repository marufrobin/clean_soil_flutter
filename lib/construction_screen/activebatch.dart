// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [],
              )
            ],
          ),
        ),
      ),
    );
  }
}
