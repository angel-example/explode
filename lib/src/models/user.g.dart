// GENERATED CODE - DO NOT MODIFY BY HAND

part of explode.models.user;

// **************************************************************************
// Generator: JsonModelGenerator
// **************************************************************************

class User extends _User {
  @override
  String email;

  @override
  String username;

  @override
  String password;

  @override
  List<String> roles;

  User({this.email, this.username, this.password, this.roles});

  factory User.fromJson(Map data) {
    return new User(
        email: data['email'],
        username: data['username'],
        password: data['password'],
        roles: data['roles']);
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'username': username,
        'password': password,
        'roles': roles
      };

  static User parse(Map map) => new User.fromJson(map);

  User clone() {
    return new User.fromJson(toJson());
  }
}
