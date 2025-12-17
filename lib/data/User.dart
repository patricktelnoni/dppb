class User{
  int? userId;
  String? email;
  String? password;
  String? access_token;
  String? name;

  User({
    this.userId,
    this.email,
    this.password,
    this.access_token,
    this.name
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json["id"],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      access_token: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() => {'password': password, 'name': name, 'email': email};
}