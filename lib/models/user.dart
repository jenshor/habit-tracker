import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;

  User({
    this.id,
    this.name,
    this.email,
  });

  @override
  List<Object> get props => [id, name, email];
}
