import 'dart:convert';

class UserModel {
  UserModel({this.name, this.accessToken});

  final String name;
  String accessToken;

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'access_token': accessToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      accessToken: map['access_token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
