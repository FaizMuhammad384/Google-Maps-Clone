import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LatLngToAddressScreen extends StatefulWidget {
  const LatLngToAddressScreen({super.key});

  @override
  State<LatLngToAddressScreen> createState() => _LatlngToAddressScreenState();
}

class _LatlngToAddressScreenState extends State<LatLngToAddressScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    /// convert coordinates to address
                    // coordinates ko address mein kaisy convert karna hy

                    List<Placemark> placeMark = await placemarkFromCoordinates(26.8467, 80.9462);
                    print("Location: ${placeMark}");
                    print("Location Name: ${placeMark.first.administrativeArea}");
                    print("Location Locality: ${placeMark.first.locality}");
                    print("Location PostalCode: ${placeMark.first.postalCode}");


                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    "Convert LatLng to Address",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () async {
                   /// Convert Address into LatLng
                    ///

                  List<Location> location = await locationFromAddress("Karachi");

                  print("Location: ${location}");
                  print("Location Latitude: ${location.first.latitude}");
                  print("Location Longitude: ${location.first.longitude}");


                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(
                    "Convert Address into LatLng",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
