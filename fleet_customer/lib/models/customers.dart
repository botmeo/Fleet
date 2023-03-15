class Customers {
  String id;
  String name;
  String phone;
  String email;
  double balance;

  Customers({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.balance,
  });

  factory Customers.fromJson(Map<String, dynamic> json, String id) => Customers(
        id: id,
        name: json['Name'],
        phone: json['Phone'],
        email: json['Email'],
        balance: json['Balance'],
      );

  Map<String, dynamic> toJson() => {
        'Name': name,
        'Phone': phone,
        'Email': email,
      };
}
