import 'package:flutter/cupertino.dart';

import '../../domain/entities/seed.dart';

class SeedModel extends Seed {
  SeedModel({
    @required String seed,
    @required DateTime expiresAt,
  }) : super(
          seed: seed,
          expiresAt: expiresAt,
        );

  factory SeedModel.fromJson(Map<String, dynamic> json) {
    return SeedModel(
      seed: json['seed'],
      expiresAt: DateTime.parse(json['expires_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "seed": seed,
      "expires_at": expiresAt.toIso8601String(),
    };
  }
}
