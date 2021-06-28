import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../lib/core/errors/exceptions.dart';
import '../../../../../lib/features/generate/data/datasources/seed_local_data_source.dart';
import '../../../../../lib/features/generate/data/models/seed_model.dart';
import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  SeedLocalDataSourceImpl dataSource;
  MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = SeedLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastSeed', () {
    final tSeedModel =
        SeedModel.fromJson(json.decode(fixture('seed_cached.json')));

    test(
      'should return SeedModel from SharedPreferences when there is one in the cache',
      () async {
        // arrange
        when(mockSharedPreferences.getString(any))
            .thenReturn(fixture('seed_cached.json'));
        // act
        final result = await dataSource.getLastSeed();
        // assert
        verify(mockSharedPreferences.getString(CACHED_SEED));
        expect(result, equals(tSeedModel));
      },
    );
  });

  test('should throw a CacheException when there is not a cached value', () {
    when(mockSharedPreferences.getString(any)).thenReturn(null);
    final call = dataSource.getLastSeed;
    expect(() => call(), throwsA(isA<CacheException>()));
  });

  group('cacheSeed', () {
    final tSeedModel = SeedModel(
      seed: "seed cached",
      expiresAt: DateTime.parse('1979-11-12T13:10:42.240Z'),
    );

    test('should call SharedPreferences to cache the data', () {
      // act
      dataSource.cacheSeed(tSeedModel);
      // assert
      final expectedJsonString = json.encode(tSeedModel.toJson());
      verify(mockSharedPreferences.setString(
        CACHED_SEED,
        expectedJsonString,
      ));
    });
  });
}
