import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  CustomGoogleMap({
    Key? key,
    this.projectSiteLocationLat,
    this.projectSiteLocationLng,
    this.processorSiteLocationLat,
    this.processorSiteLocationLng,
  });
  // var pickUpSite;
  var projectSiteLocationLat;
  var projectSiteLocationLng;
  var processorSiteLocationLat;
  var processorSiteLocationLng;

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Map<String, Marker> markers = {};
  @override
  Widget build(BuildContext context) {
    var projectSiteLat = double.parse(widget.projectSiteLocationLat);
    var projectSiteLng = double.parse(widget.projectSiteLocationLng);
    var processorSiteLat = double.parse(widget.processorSiteLocationLat);
    var processorSiteLng = double.parse(widget.processorSiteLocationLng);

    // CameraPosition _kGooglePlex =
    //     CameraPosition(target: LatLng(lat, lng), zoom: 14);
    late GoogleMapController googleMapController;

    return Scaffold(
        appBar: AppBar(
          title: Text("Location"),
        ),
        body: GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(22.3338315, 91.8300895), zoom: 10),
          onMapCreated: (controller) {
            googleMapController = controller;
            addMarker("test", LatLng(projectSiteLat, projectSiteLng));
            addMarker("test32", LatLng(processorSiteLat, processorSiteLng));
          },
          markers: markers.values.toSet(),
        ));
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
    );
    markers[id] = marker;
    setState(() {});
  }
}
