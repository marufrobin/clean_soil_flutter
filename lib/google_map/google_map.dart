import 'package:flutter/material.dart';

class CustomGoogleMap extends StatefulWidget {
  var pickUpSite;
  var projectSiteLocationLat;
  var projectSiteLocationLng;
  CustomGoogleMap(
      {Key? key,
      required this.projectSiteLocationLat,
      required this.projectSiteLocationLng})
      : super(key: key);

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Text(
            "position: ${widget.projectSiteLocationLat}---${widget.projectSiteLocationLng}"),
      ),
    );
  }
}
