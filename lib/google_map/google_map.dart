import 'dart:async';

import 'package:clean_soil_flutter/constans/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

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
  Map<String, Marker> markers = {};
  var projectSiteLat = 37.33500926;
  var projectSiteLng = -122.03272188;
  var processorSiteLat = 37.3342983;
  var processorSiteLng = -122.06600055;
  List<LatLng> polylineCorrdinates = [];

  LocationData? currentLocation;

  getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
    });
    location.onLocationChanged.listen((newLoc) {
      currentLocation = newLoc;
      setState(() {});
    });
  }

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
    getCurrentLocation();
    getPolylines();
    super.initState();
  }

  late final Completer<GoogleMapController> completer = Completer();
  @override
  Widget build(BuildContext context) {
    // var projectSiteLat = double.parse(widget.projectSiteLocationLat);
    // var projectSiteLng = double.parse(widget.projectSiteLocationLng);
    // var processorSiteLat = double.parse(widget.processorSiteLocationLat);
    // var processorSiteLng = double.parse(widget.processorSiteLocationLng);

    // CameraPosition _kGooglePlex =
    //     CameraPosition(target: LatLng(lat, lng), zoom: 14);
    // late GoogleMapController googleMapController;

    return Scaffold(
        appBar: AppBar(
          title: Text("Location"),
        ),
        body: currentLocation == null
            ? Center(
                child: Text("loading"),
              )
            : GoogleMap(
                polylines: {
                  Polyline(
                      polylineId: PolylineId("route"),
                      points: polylineCorrdinates,
                      color: Colors.blue,
                      width: 6)
                },
                initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 16),
                onMapCreated: (controller) {
                  completer.complete(controller);

                  addMarker(
                      "Current Location",
                      LatLng(currentLocation!.latitude!,
                          currentLocation!.longitude!));
                  addMarker(
                      "Pick up site", LatLng(projectSiteLat, projectSiteLng));
                  addMarker(
                      "Drop site", LatLng(processorSiteLat, processorSiteLng));
                },
                markers: markers.values.toSet(),
              ));
  }

  addMarker(String id, LatLng location) {
    var marker = Marker(
        markerId: MarkerId(id),
        position: location,
        infoWindow: InfoWindow(
          title: id,
        ));
    markers[id] = marker;
    setState(() {});
  }
}
