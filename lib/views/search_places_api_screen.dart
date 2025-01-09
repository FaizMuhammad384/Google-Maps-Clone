import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_clone/helpers/constant.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;


class SearchPlacesApiScreen extends StatefulWidget {
  const SearchPlacesApiScreen({super.key});

  @override
  State<SearchPlacesApiScreen> createState() => _SearchPlacesApiScreenState();
}

class _SearchPlacesApiScreenState extends State<SearchPlacesApiScreen> {

  /// uuid package use to get device id
  var uuid = Uuid();

  /// text editing controller
  TextEditingController searchController = TextEditingController();

  /// empty dynamic list
  List<dynamic> placesList = [];

  /// session token
  var sessionToken = "123456";

  /// on init
  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      onChange();
    });
  }

  /// on changed method
  void onChange() {
    if (sessionToken == null) {
      setState(() {
        sessionToken = uuid.v4();
      });
    }

    /// initialize method to get suggestion
    getSuggestion(searchController.text.toString());
  }

  /// suggestion method
  Future<void> getSuggestion(String input) async {

    /// google places api key
    // String kPLACES_API_KEY = apiKey;
    // String kPLACES_API_KEY = Go_Map_PRO_API_KEY;
    // String baseURL ='https://maps.googleapis.com/maps/api/place/autocomplete/json';
    // String request = '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$sessionToken';

    String request = "https://maps.gomaps.pro/maps/api/place/autocomplete/json?input=$input&key=$Go_Map_PRO_API_KEY";

    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        placesList = jsonDecode(response.body.toString()) ["predictions"];
      });
      print("PlacesList: $placesList");
    } else {
      throw Exception("Failed to load data!!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Places Api",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search Places Api",
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: placesList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(placesList[index]["description"]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
