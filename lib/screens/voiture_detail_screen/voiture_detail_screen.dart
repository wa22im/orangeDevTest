import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:orangeTest/models/voiture.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class VoitureDatail extends StatefulWidget {
  final String carId;
  VoitureDatail({Key key, this.carId}) : super(key: key);

  @override
  _VoitureDatailState createState() => _VoitureDatailState(this.carId);
}

class _VoitureDatailState extends State<VoitureDatail> {
  String carId;
  Voiture voiture;
  _VoitureDatailState(String carId) {
    this.carId = carId;
  }
  String url = "http://demo2870336.mockable.io/";
  void fetchData() async {
    final response = await http.get(url + carId);
    if (response.statusCode == 200) {
      var responseFrom = json.decode(response.body);
      voiture = new Voiture(
          carId: responseFrom["carId"].toString(),
          damageDescription: responseFrom["damageDescription"],
          fuelLevel: int.parse(responseFrom["fuelLevel"].toString()),
          hardwareId: responseFrom["hardwareId"],
          isClean: responseFrom["isClean"],
          isDamaged: responseFrom["isDamaged"],
          lat: responseFrom["lat"],
          lon: responseFrom["lon"],
          licencePlate: responseFrom["licencePlate"],
          pricingParking: responseFrom["pricingParking"],
          pricingTime: responseFrom["pricingTime"],
          reservationState:
              int.parse(responseFrom["reservationState"].toString()),
          title: responseFrom["title"],
          vehicleTypeId: int.parse(responseFrom["vehicleTypeId"].toString()),
          vehicleTypeImageUrl: responseFrom["vehicleTypeImageUrl"]);

      print(voiture.vehicleTypeImageUrl + "vo");

      setState(() {
        voiture = voiture;
      });
    }
    ;
  }

  @override
  void initState() {
    super.initState();
    print("details ");

    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details ",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Color(0xAAFF6600),
      ),
      body: SafeArea(
        child: this.voiture == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: [
                      ListTile(
                          leading: this.voiture == null
                              ? Icon(Icons.car_rental)
                              : Image.network(this.voiture.vehicleTypeImageUrl),
                          title: Row(
                            children: [
                              Text(
                                this.voiture.title,
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(
                                "licencePlate  :" + this.voiture.licencePlate,
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                'fuelLevel :' +
                                    this.voiture.fuelLevel.toString(),
                                style: TextStyle(color: Colors.black),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Clean',
                                style: TextStyle(
                                    color: this.voiture.isClean
                                        ? Colors.green.withOpacity(0.6)
                                        : Colors.red.withOpacity(0.6),
                                    decoration: this.voiture.isClean
                                        ? null
                                        : TextDecoration.lineThrough),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Damaged',
                                style: TextStyle(
                                    color: this.voiture.isDamaged
                                        ? Colors.green.withOpacity(0.6)
                                        : Colors.red.withOpacity(0.6),
                                    decoration: this.voiture.isClean
                                        ? null
                                        : TextDecoration.lineThrough),
                              ),
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          this.voiture.damageDescription,
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("hardwareId  : " + this.voiture.hardwareId),
                          Text("pricingTime  : " + this.voiture.pricingTime),
                          Text("pricingParking  : " +
                              this.voiture.pricingParking),
                          Text("reservationState  : " +
                              this.voiture.reservationState.toString()),
                        ],
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
