class Trucks {
  String id;
  String licensePlate;
  String model;
  String year;
  String manufacture;
  String type;
  int capacity;
  int cost;
  String status;
  String used;
  double currentLat;
  double currentLng;

  Trucks({
    this.id,
    this.licensePlate,
    this.model,
    this.year,
    this.manufacture,
    this.capacity,
    this.cost,
    this.status,
    this.used,
    this.currentLat,
    this.currentLng,
  });

  factory Trucks.fromJson(Map<String, dynamic> json, String id) => Trucks(
        id: id,
        licensePlate: json['LicensePlate'],
        model: json['Model'],
        year: json['Year'],
        manufacture: json['Manufacture'],
        capacity: json['Capacity'],
        cost: json['Cost'],
        status: json['Status'],
        currentLat: json['CurrentLat'],
        currentLng: json['CurrentLng'],
      );

  Map<String, dynamic> toJson() => {
        'licensePlate': licensePlate,
        'model': model,
        'year': year,
        'manufacture': manufacture,
        'capacity': capacity,
        'cost': cost,
        'status': status,
        'currentLat': currentLat,
        'currentLong': currentLng,
      };
}
