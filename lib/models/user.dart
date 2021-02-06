import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:habit_tracker/models/model.dart';

import 'id.dart';

class User extends Model {
  final String firstName;
  final String lastName;
  final String email;

  String get fullName => '$firstName $lastName';

  User({
    @required Id id,
    this.firstName,
    this.lastName,
    this.email,
  }) : super(id: id);

  @override
  List<Object> get props => [id, firstName, lastName, email];

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: Id.fromMap(map['id']),
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
