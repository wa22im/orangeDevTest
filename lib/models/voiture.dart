class Voiture {
  String carId;
  String title;
  bool isClean;
  bool isDamaged;
  String licencePlate;
  int fuelLevel;
  String hardwareId;
  int vehicleTypeId;
  String pricingTime;
  String pricingParking;
  double lat;
  double lon;
  int reservationState;
  String damageDescription;
  String vehicleTypeImageUrl;

  Voiture(
      {this.carId,
      this.title,
      this.isClean,
      this.isDamaged,
      this.licencePlate,
      this.fuelLevel,
      this.hardwareId,
      this.vehicleTypeId,
      this.pricingParking,
      this.pricingTime,
      this.lat,
      this.lon,
      this.reservationState,
      this.damageDescription,
      this.vehicleTypeImageUrl});

  factory Voiture.fromJson(Map<String, dynamic> map) {
    return Voiture(
      carId: map["cardId"],
      title: map["title"] as String,
      isClean: map["isClean"] as bool,
      isDamaged: map["isDamaged"] as bool,
      licencePlate: map["licencePlate"] as String,
      fuelLevel: map["fuelLevel"] as int,
      hardwareId: map["hardwareId"] as String,
      vehicleTypeId: map["vehicleTypeId"] as int,
      pricingTime: map["pricingTime"] as String,
      pricingParking: map["pricingParking"] as String,
      lat: map["lat"] as double,
      lon: map["lon"] as double,
      reservationState: map["reservationState"] as int,
      damageDescription: map["damageDescription"] as String,
      vehicleTypeImageUrl: map["vehicleTypeImageUrl"] as String,
    );
  }
}
