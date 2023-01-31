// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:clean_soil_flutter/construction_screen/dashboard_active.dart';
import 'package:clean_soil_flutter/construction_screen/dashboard_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pageview_widget_indicator/pageview_widget_indicator.dart';

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
              padding: const EdgeInsets.only(top: 51, left: 16),
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
                padding: const EdgeInsets.only(top: 51, right: 20),
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
                  // padding:
                  //     EdgeInsets.only(top: 8, bottom: 8, left: 23, right: 24),
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


// import 'package:flutter/material.dart';
// import 'Chat.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(

//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Flutter TabBar Example - Customized "),
//         ),
//         body: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Container(
//                 height: 45,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(25.0)
//                 ),
//                 child:  TabBar(
//                   indicator: BoxDecoration(
//                     color: Colors.green[300],
//                     borderRadius:  BorderRadius.circular(25.0)
//                   ) ,
//                   labelColor: Colors.white,
//                   unselectedLabelColor: Colors.black,
//                   tabs: const  [
//                     Tab(text: 'Chats',),
//                     Tab(text: 'Status',),
//                     Tab(text: 'Calls',),
//                     Tab(text: 'Settings',)
//                   ],
//                 ),
//               ),
//               const Expanded(
//                   child: TabBarView(
//                     children:  [
//                       Center(child: Text("Chats Pages"),),
//                       Center(child: Text("Status Pages"),),
//                       Center(child: Text('Calls Page'),),
//                       Center(child: Text('Settings Page'),)
//                     ],
//                   )
//               )
//             ],
//           ),
//         )
//       ),
//     );
//   }
// }