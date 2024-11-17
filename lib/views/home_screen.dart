import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  /// initialize google map controller
 final Completer<GoogleMapController> googleMapController = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Google Map",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        compassEnabled: true,
        onMapCreated: (GoogleMapController controller){
          googleMapController.complete(controller);
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.43296265331129, -122.08832357078792),
          zoom: 10, /// first time ya view appear ho ga
        ),
      ),
    );
  }
}


/// Google map console api key enable