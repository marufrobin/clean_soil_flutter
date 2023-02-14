import 'dart:async';

import 'package:clean_soil_flutter/constans/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  CustomGoogleMap({
    Key? key,
    // this.projectSiteLocationLat,
    // this.projectSiteLocationLng,
    // this.processorSiteLocationLat,
    // this.processorSiteLocationLng,
  });
  // var pickUpSite;
  // var projectSiteLocationLat;
  // var projectSiteLocationLng;
  // var processorSiteLocationLat;
  // var processorSiteLocationLng;
  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Map<String, Marker> markers = {};
  var projectSiteLat = 24.8821807;
  var projectSiteLng = 91.868253;
  var processorSiteLat = 22.3338315;
  var processorSiteLng = 91.8300895;
  List<LatLng> polylineCorrdinates = [];
  getPolylines() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapApiKey,
        PointLatLng(projectSiteLat, projectSiteLng),
        PointLatLng(processorSiteLat, processorSiteLng));
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) =>
          polylineCorrdinates.add(LatLng(point.latitude, point.longitude)));
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getPolylines();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var projectSiteLat = double.parse(widget.projectSiteLocationLat);
    // var projectSiteLng = double.parse(widget.projectSiteLocationLng);
    // var processorSiteLat = double.parse(widget.processorSiteLocationLat);
    // var processorSiteLng = double.parse(widget.processorSiteLocationLng);

    // CameraPosition _kGooglePlex =
    //     CameraPosition(target: LatLng(lat, lng), zoom: 14);
    late GoogleMapController googleMapController;

    return Scaffold(
        appBar: AppBar(
          title: Text("Location"),
        ),
        body: GoogleMap(
          polylines: {
            Polyline(
                polylineId: PolylineId("route"),
                points: polylineCorrdinates,
                color: Colors.blue,
                width: 6)
          },
          initialCameraPosition:
              CameraPosition(target: LatLng(22.3338315, 91.8300895), zoom: 8),
          onMapCreated: (controller) {
            googleMapController = controller;
            addMarker("Pick up site", LatLng(projectSiteLat, projectSiteLng));
            addMarker("Drop site", LatLng(processorSiteLat, processorSiteLng));
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
