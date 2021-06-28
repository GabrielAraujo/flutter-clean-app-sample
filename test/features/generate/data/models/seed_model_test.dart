import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

import '../../../../../lib/features/generate/data/models/seed_model.dart';
import '../../../../../lib/features/generate/domain/entities/seed.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tSeedModel = SeedModel(
    seed: "seed",
    expiresAt: DateTime.parse('1979-11-12T13:10:42.240Z'),
  );

  test(
    'Should be a subclass of Seed entity',
    () async {
      expect(tSeedModel, isA<Seed>());
    },
  );

  group('fromJson', () {
    test('Should return a valid model', () {
      final Map<String, dynamic> jsonMap = json.decode(fixture('seed.json'));

      final result = SeedModel.fromJson(jsonMap);

      expect(result, tSeedModel);
    });
  });

  group('toJson', () {
    test('Should return a JSON map considering the proper data', () {
      final Map<String, dynamic> result = tSeedModel.toJson();

      final expectedJsonMap = {
        "seed": "seed",
        "expires_at": "1979-11-12T13:10:42.240Z"
      };

      expect(result, expectedJsonMap);
    });
  });
}
