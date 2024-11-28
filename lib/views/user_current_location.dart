import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// package vs plugin

class UserCurrentLocation extends StatefulWidget {
  const UserCurrentLocation({super.key});

  @override
  State<UserCurrentLocation> createState() => _UserCurrentLocationState();
}

class _UserCurrentLocationState extends State<UserCurrentLocation> {
  /// completer
  Completer<GoogleMapController> googleMapController = Completer();


  /// list of markers
  List<Marker> markers = [];

  /// get user current location
  Future<Position> getUserCurrentLocation() async {


    /// request permission
    await Geolocator.requestPermission().then((value) {
      print("User request permission: ${value}");
    }).catchError((error) {
      print("User request permission Error : ${error}");
    });

    /// get user location
    return await Geolocator.getCurrentPosition();
  }

  /// get data from user current location
    getUserCurrentLocationData() {
    getUserCurrentLocation().then((value) async {
      print("User Latitude: ${value.latitude}");
      print("User Longitude: ${value.longitude}");

      /// current user marker
      markers.add(Marker(
        markerId: MarkerId("Second Location"),
        position: LatLng(value.latitude,value.longitude),
        infoWindow: InfoWindow(title: "Current Location"),
       ),);

      final GoogleMapController controller = await googleMapController.future;

      final CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
        zoom: 14,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});
    })
        .catchError((error) {
      print("Error: ${error}");
    });
  }


  @override
  void initState() {
    markers.add(Marker(
        markerId: MarkerId("First Location"),
        position: LatLng(20.5937, 78.9629),
        infoWindow: InfoWindow(title: "India"),
      ),);
    // getUserCurrentLocationData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        compassEnabled: true,
        mapType: MapType.normal,
        markers: Set<Marker>.of(markers),
        onMapCreated: (GoogleMapController controller) {
          googleMapController.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(20.5937, 78.9629),
          zoom: 14,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          getUserCurrentLocationData();
        },
        child: Icon(Icons.location_on_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}



/// permissions
// coarse location
// fine location
// background location










