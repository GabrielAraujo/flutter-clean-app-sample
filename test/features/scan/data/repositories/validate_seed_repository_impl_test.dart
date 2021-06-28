import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/core/errors/exceptions.dart';
import '../../../../../lib/features/scan/data/datasources/validate_seed_remote_data_source.dart';
import '../../../../../lib/features/scan/data/repositories/validate_seed_repository_impl.dart';

class MockRemoteDataSource extends Mock
    implements ValidateSeedRemoteDataSource {}

void main() {
  ValidateSeedRepositoryImpl repository;
  MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = ValidateSeedRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  group(
    'validateSeed',
    () {
      final tSeed = "seed";

      group('remote sources', () {
        test(
          'should return success when seed is validates',
          () async {
            when(mockRemoteDataSource.validateSeed(tSeed))
                .thenAnswer((_) async => true);

            final result = await repository.validateSeed(tSeed);

            verify(mockRemoteDataSource.validateSeed(tSeed));
            expect(result, equals(true));
          },
        );

        test(
          'should return server failure when the call to remote data source is unsuccessful',
          () async {
            when(mockRemoteDataSource.validateSeed(tSeed))
                .thenThrow(ServerException());
            expect(() async => await repository.validateSeed(tSeed),
                throwsA(isA<ServerException>()));
            verify(mockRemoteDataSource.validateSeed(tSeed));
          },
        );
      });
    },
  );
}
