import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  CustomGoogleMap({
    Key? key,
  }) : super(key: key);
  var pickUpSite;
  // var projectSiteLocationLat=0;
  // var projectSiteLocationLng=0;

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    // var lat = double.parse(widget.projectSiteLocationLat);
    // var lng = double.parse(widget.projectSiteLocationLng);
    // CameraPosition _kGooglePlex =
    //     CameraPosition(target: LatLng(lat, lng), zoom: 14);

    return Scaffold(
        appBar: AppBar(
          title: Text("Location"),
        ),
        body: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(24.88, 91.86), zoom: 14),
        ));
  }
}
