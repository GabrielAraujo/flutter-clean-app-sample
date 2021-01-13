import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Seed extends Equatable {
  final String seed;
  final DateTime expiresAt;

  Seed({
    @required this.seed,
    @required this.expiresAt,
  });

  @override
  List<Object> get props => [seed, expiresAt];
}
