import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orangeTest/models/voiture.dart';
import 'package:http/http.dart' as http;
import 'package:orangeTest/screens/voiture_detail_screen/voiture_detail_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:orangeTest/widgets/googlemap/googleMap.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Voiture> voitureFromJson = new List<Voiture>();
  String url = "http://demo2870336.mockable.io/data";
  Position _currentPosition;
  String _currentAddress;

  Position position;

  void fetchData() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      Iterable listreponse = json.decode(response.body);
      voitureFromJson = listreponse.map((e) => Voiture.fromJson(e)).toList();
      setState(() {
        voitureFromJson = voitureFromJson;
      });
    }
  }

  void geo() async {
    LocationPermission permission = await Geolocator.requestPermission();

    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    geo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MapSample(),
                  ),
                );
              },
              icon: Icon(Icons.map),
              label: Text("To map")),
        ],
        title: Text(
          "Trouver Mon Voiture",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xAAFF6600),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              if (_currentPosition != null && _currentAddress != null)
                Text(_currentAddress),
              SizedBox(
                height: MediaQuery.of(context).size.height - 100,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: this.voitureFromJson.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      trailing: FlatButton(
                        child: Text("Check Details"),
                        onPressed: () {
                          print(index);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VoitureDatail(
                                        carId: index.toString(),
                                      )));
                        },
                      ),
                      leading: Image.network(
                          this.voitureFromJson[index].vehicleTypeImageUrl),
                      title: Text(this.voitureFromJson[index].title),
                      subtitle: Text(
                        "Longtitue :" +
                            this.voitureFromJson[index].lon.toString() +
                            " laltitude :" +
                            this.voitureFromJson[index].lat.toString(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
