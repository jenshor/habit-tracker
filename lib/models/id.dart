import 'dart:convert';

import 'package:equatable/equatable.dart';

class Id extends Equatable {
  final String value;
  Id(
    this.value,
  );

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }

  factory Id.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Id(
      map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Id.fromJson(String source) => Id.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [value];
}
