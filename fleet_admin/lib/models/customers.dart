class Customers {
  String id;
  String name;
  String phone;
  String email;

  Customers({
    this.id,
    this.name,
    this.phone,
    this.email,
  });

  factory Customers.fromJson(Map<String, dynamic> json, String id) => Customers(
        id: id,
        name: json['Name'],
        phone: json['Phone'],
        email: json['Email'],
      );

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Phone': phone,
        'Email': email,
      };
}
