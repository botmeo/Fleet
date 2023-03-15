class DriverUser {
  String id;
  String email;
  String password;
  String name;
  String birthday;
  String phone;

  DriverUser({
    this.id,
    this.email,
    this.password,
    this.name,
    this.birthday,
    this.phone,
  });

  factory DriverUser.fromJson(Map<String, dynamic> json, String id) {
    return DriverUser(
      id: id,
      email: json['Email'],
      name: json['Name'],
      birthday: json['Birthday'],
      phone: json['Phone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        // 'birthday': birthday,
        // 'phone': phone,
      };
}
