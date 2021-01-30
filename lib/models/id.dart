import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class Id extends Equatable {
  final String value;
  final DateTime createdDate;
  final DateTime changedDate;

  Id(
    this.value, {
    this.createdDate,
    this.changedDate,
  });

  Id.fromDate({
    @required DateTime date,
    String value,
  })  : this.changedDate = date,
        this.createdDate = date,
        this.value = value;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [
        this.value,
        this.createdDate,
        this.changedDate,
      ];

  Id copyWith({
    String value,
    DateTime createdDate,
    DateTime changedDate,
  }) {
    return Id(
      value ?? this.value,
      createdDate: createdDate ?? this.createdDate,
      changedDate: changedDate ?? this.changedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'createdDate': createdDate?.millisecondsSinceEpoch,
      'changedDate': changedDate?.millisecondsSinceEpoch,
    };
  }

  factory Id.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Id(
      map['value'],
      createdDate: DateTime.fromMillisecondsSinceEpoch(map['createdDate']),
      changedDate: DateTime.fromMillisecondsSinceEpoch(map['changedDate']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Id.fromJson(String source) => Id.fromMap(json.decode(source));
}
