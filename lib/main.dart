import 'package:clean_soil_flutter/authentication/account_signIn.dart';
import 'package:clean_soil_flutter/scanner/qr_scanner.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Soil',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: AccountSignInPage(),
    );
  }
}

class NavigateToQRPage extends StatelessWidget {
  const NavigateToQRPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => QRViewExample(),
            ));
          },
          icon: Icon(Icons.document_scanner),
          label: Text("Scan"),
        ),
      ),
    );
  }
}
