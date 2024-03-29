import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../../lib/core/usecases/usecase.dart';
import '../../../../../lib/features/generate/domain/entities/seed.dart';
import '../../../../../lib/features/generate/domain/repositories/get_seed_repository.dart';
import '../../../../../lib/features/generate/domain/usecases/get_seed_usecase.dart';

class MockGetSeedRepository extends Mock implements GetSeedRepository {}

void main() {
  GetSeedUsecase useCase;
  MockGetSeedRepository mockGetSeedRepository;

  setUp(() {
    mockGetSeedRepository = MockGetSeedRepository();
    useCase = GetSeedUsecase(repository: mockGetSeedRepository);
  });

  final tSeed = Seed(seed: "seed", expiresAt: DateTime.now());

  test('Should get seed form the repository', () async {
    when(mockGetSeedRepository.getSeed()).thenAnswer((_) async => tSeed);

    final result = await useCase(NoParams());

    expect(result, tSeed);

    verify(mockGetSeedRepository.getSeed());

    verifyNoMoreInteractions(mockGetSeedRepository);
  });
}
