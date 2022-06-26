class User {
  String? status,
      name,
      lname,
      mail,
      token,
      phone,
      code,
      nationalCode,
      userName,
      dateOfBirth;
  int? balance, genderId;

  User({
    this.status,
    this.name,
    this.balance,
    this.lname,
    this.mail,
    this.token,
    this.phone,
    this.code,
    this.nationalCode,
    this.userName,
    this.dateOfBirth,
    this.genderId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      status: json["status"],
      name: json["firstName"],
      lname: json["lastName"],
      mail: json["email"],
      token: json["token"],
      phone: json["phone"],
      code: json["code"],
      nationalCode: json["nationalCode"],
      userName: json["userName"],
      dateOfBirth: json["dob"],
      genderId: json["gender"],
    );
  }
}
