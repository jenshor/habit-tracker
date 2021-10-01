import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:habit_tracker/models/model.dart';

import 'id.dart';

class User extends Model {
  final String name;
  final String email;

  User({
    @required Id id,
    this.name,
    this.email,
  }) : super(id: id);

  @override
  List<Object> get props => [id, name, email];

  Map<String, dynamic> toMap() {
    return {
      'id': id?.toMap(),
      'name': name,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: Id.fromMap(map['id']),
      name: map['name'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    Id id,
    String firstName,
    String lastName,
    String email,
  }) {
    return User(
      id: id ?? this.id,
      name: firstName ?? this.name,
      email: email ?? this.email,
    );
  }
}
