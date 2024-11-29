import 'dart:async';
import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:google_maps_clone/helpers/constant.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


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
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              compassEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                googleMapController.complete(controller);
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(30.9693, 70.9428),
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: MarkerId("marker"),
                  position: LatLng(30.9473893,70.9258417),
                  infoWindow: InfoWindow(
                    title: "Dps School",
                    snippet: "My Current Location",
                  ),
                ),
                Marker(
                  markerId: MarkerId("marker_01"),
                  position: LatLng(30.9472792,70.9438665),
                  infoWindow: InfoWindow(
                    title: "Kips College",
                    snippet: "Layyah",
                  ),
                ),
              },

            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () async {
              GoogleMapController controller = await googleMapController.future;
              setState(() {
                controller.animateCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: LatLng(26.8467, 80.9462),
                    zoom: 14,
                  ),
                ));
              });
            },
            child: Text(
              "Animate Camera Position",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

