class Drivers {
  String id;
  String name;
  String birthday;
  String phone;
  String email;

  Drivers({
    this.id,
    this.name,
    this.birthday,
    this.phone,
    this.email,
  });

  factory Drivers.fromJson(Map<String, dynamic> json, String id) => Drivers(
        id: id,
        name: json['Name'],
        birthday: json['Birthday'],
        phone: json['Phone'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'birthday': birthday,
        'phone': phone,
      };
}
