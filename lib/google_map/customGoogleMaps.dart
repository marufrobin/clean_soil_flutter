// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:location/location.dart' as loc;
import 'package:url_launcher/url_launcher.dart';

class CustomGoogleMaps extends StatefulWidget {
  CustomGoogleMaps({Key? key, this.destinationLat, this.destinationLng})
      : super(key: key);
  var destinationLat;
  var destinationLng;
  @override
  State<CustomGoogleMaps> createState() => _CustomGoogleMapsState();
}

const googleMapsApiKey = "AIzaSyC_s2zNUWs7BXpFFf1ImzArtJpJXd-Dv9Q";

class _CustomGoogleMapsState extends State<CustomGoogleMaps> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  final Completer<GoogleMapController> _completer = Completer();

  Map<PolylineId, Polyline> polylines = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Location location = Location();
  Marker? sourcePosition, destinationPosition;

  loc.LocationData? currentPosition;

  var currentLocation = const LatLng(22.3366, 91.8200);
  var destinationLocation;

  StreamSubscription<loc.LocationData>? locationSubscription;

  void addCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(devicePixelRatio: 3.5),
      "images/truckIconNew.png",
    ).then((icon) {
      setState(() {
        this.markerIcon = icon;
      });
    });
  }

  addMarker() {
    setState(() {
      sourcePosition = Marker(
        markerId: MarkerId("Source"),
        position: currentLocation,
        icon: markerIcon,
      );
      destinationPosition = Marker(
        markerId: MarkerId("destination"),
        position: destinationLocation,
      );
    });
  }

  getNavigation() async {
    bool serviceEnable;
    PermissionStatus permissionStatus;
    final GoogleMapController controller = await _completer.future;
    location.changeSettings(accuracy: loc.LocationAccuracy.high);
    serviceEnable = await location.serviceEnabled();

    if (!serviceEnable) {
      serviceEnable = await location.requestService();
      if (!serviceEnable) {
        return;
      }
    }
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        return;
      }
    }
    if (permissionStatus == PermissionStatus.granted) {
      currentPosition = await location.getLocation();
      currentLocation =
          LatLng(currentPosition!.latitude!, currentPosition!.longitude!);
      locationSubscription =
          location.onLocationChanged.listen((LocationData currentLocations) {
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target:
              LatLng(currentLocations.latitude!, currentLocations.longitude!),
          zoom: 16,
        )));
        if (mounted) {
          controller
              .showMarkerInfoWindow(MarkerId(sourcePosition!.markerId.value));
          setState(() {
            currentLocation = LatLng(currentLocations.latitude!.toDouble(),
                currentLocations.longitude!);
            sourcePosition = Marker(
              markerId: MarkerId("Source"),
              position: LatLng(
                  currentLocations.latitude!, currentLocations.longitude!),
              infoWindow: InfoWindow(title: "Current Location"),
              icon: markerIcon,
            );
          });
          getDirection(LatLng(
              destinationLocation.latitude, destinationLocation.longitude));
          print(
              "current location:::::${LatLng(currentLocation.latitude, currentLocation.longitude)}");
          // print(
          //     "locationnn:::::${LatLng(destinationLocation.latitude, destinationLocation.longitude)}");
        }
      });
    }
  }

  getDirection(LatLng destination) async {
    List<LatLng> polylineCoordinates = [];
    List<dynamic> points = [];
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleMapsApiKey,
        PointLatLng(currentLocation.latitude, currentLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude),
        travelMode: TravelMode.driving);
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng pointLatLng) {
        polylineCoordinates
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
        points.add({'lat': pointLatLng.latitude, "lng": pointLatLng.longitude});
      });
    } else {
      print(result.errorMessage);
    }
    addPolyline(polylineCoordinates);
  }

  addPolyline(List<LatLng> polylinecoordinates) {
    PolylineId id = PolylineId("PolyLine");
    Polyline polyline = Polyline(
        polylineId: id,
        color: Colors.blue,
        points: polylinecoordinates,
        width: 3);
    polylines[id] = polyline;
    setState(() {});
  }

  @override
  void initState() {
    destinationLocation = LatLng(widget.destinationLat, widget.destinationLng);
    print("destination of ::::::$destinationLocation");
    addCustomMarkerIcon();
    addMarker();
    getNavigation();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    locationSubscription?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await launchUrl(Uri.parse(
                "google.navigation:q=${destinationLocation.latitude}, ${destinationLocation.longitude}&key=$googleMapsApiKey"));
          },
          child: Icon(Icons.navigation_rounded)),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Google Maps",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: sourcePosition == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: currentLocation,
                zoom: 16,
              ),
              polylines: Set<Polyline>.of(polylines.values),
              markers: {sourcePosition!, destinationPosition!},
              onMapCreated: (GoogleMapController controller) {
                _completer.complete(controller);
              },
              onTap: (latlng) => print(latlng),
            ),
    );
  }
}
