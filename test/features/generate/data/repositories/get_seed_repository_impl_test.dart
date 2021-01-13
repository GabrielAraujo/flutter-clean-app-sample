import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:superformula/core/errors/exceptions.dart';
import 'package:superformula/core/platform/network_info.dart';
import 'package:superformula/features/generate/data/datasources/seed_local_data_source.dart';
import 'package:superformula/features/generate/data/datasources/seed_remote_data_source.dart';
import 'package:superformula/features/generate/data/models/seed_model.dart';
import 'package:superformula/features/generate/data/repositories/get_seed_repository_impl.dart';

class MockRemoteDataSource extends Mock implements SeedRemoteDataSource {}

class MockLocalDataSource extends Mock implements SeedLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  GetSeedRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;
  MockLocalDataSource mockLocalDataSource;
  MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = GetSeedRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getSeed', () {
    final tSeedModel = SeedModel(
      seed: "seed",
      expiresAt: DateTime.parse('1979-11-12T13:10:42.240Z'),
    );

    test('should check if device is online', () {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);

      repository.getSeed();

      verify(mockNetworkInfo.isConnected);
    });

    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test(
        'should return remote data when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.getSeed())
              .thenAnswer((_) async => tSeedModel);

          final result = await repository.getSeed();

          verify(mockRemoteDataSource.getSeed());
          expect(result, equals(tSeedModel));
        },
      );

      test(
        'should  cache the data locally when the call to remote data source is successful',
        () async {
          when(mockRemoteDataSource.getSeed())
              .thenAnswer((_) async => tSeedModel);

          await repository.getSeed();

          verify(mockRemoteDataSource.getSeed());
          verify(mockLocalDataSource.cacheSeed(tSeedModel));
        },
      );

      test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
          when(mockRemoteDataSource.getSeed()).thenThrow(ServerException());
          expect(() async => await repository.getSeed(),
              throwsA(isA<ServerException>()));
          verify(mockRemoteDataSource.getSeed());
          verifyZeroInteractions(mockLocalDataSource);
        },
      );
    });

    group('device is offline', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      });

      test(
        'should return last locally cached data when the cached data is present',
        () async {
          when(mockRemoteDataSource.getSeed())
              .thenAnswer((_) async => tSeedModel);

          final result = await repository.getSeed();

          verifyZeroInteractions(mockRemoteDataSource);
          verify(mockLocalDataSource.getLastSeed());
          expect(result, equals(tSeedModel));
        },
      );

      test(
        'should return cache failure when the call to local data source is unsuccessful',
        () async {
          when(mockRemoteDataSource.getSeed()).thenThrow(CacheException());
          expect(() async => await repository.getSeed(),
              throwsA(isA<CacheException>()));
          verify(mockLocalDataSource.getLastSeed());
          verifyZeroInteractions(mockRemoteDataSource);
        },
      );
    });
  });
}
