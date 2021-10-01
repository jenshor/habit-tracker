import 'package:equatable/equatable.dart';

import 'id.dart';
import 'package:meta/meta.dart';

@immutable
abstract class Model extends Equatable {
  final Id id;

  Model({
    @required this.id,
  });

  Map<String, dynamic> toMap();
}
