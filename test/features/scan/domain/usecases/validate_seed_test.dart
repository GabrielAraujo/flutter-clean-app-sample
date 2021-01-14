import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:superformula/core/usecases/usecase.dart';
import 'package:superformula/features/generate/domain/entities/seed.dart';
import 'package:superformula/features/generate/domain/repositories/get_seed_repository.dart';
import 'package:superformula/features/generate/domain/usecases/get_seed_usecase.dart';
import 'package:superformula/features/scan/domain/repositories/validate_seed_repository.dart';
import 'package:superformula/features/scan/domain/usecases/validate_seed_usecase.dart';

class MockValidateSeedRepository extends Mock
    implements ValidateSeedRepository {}

void main() {
  ValidateSeedUsecase useCase;
  MockValidateSeedRepository mockValidateSeedRepository;

  setUp(() {
    mockValidateSeedRepository = MockValidateSeedRepository();
    useCase = ValidateSeedUsecase(repository: mockValidateSeedRepository);
  });

  final tSeed = "seed";

  test('Should get success form the repository', () async {
    when(mockValidateSeedRepository.validateSeed(tSeed))
        .thenAnswer((_) async => true);

    final result = await useCase(Params(seed: tSeed));

    expect(result, true);

    verify(mockValidateSeedRepository.validateSeed(tSeed));

    verifyNoMoreInteractions(mockValidateSeedRepository);
  });
}
