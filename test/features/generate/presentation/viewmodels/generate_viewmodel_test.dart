import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:superformula/core/viewmodels/base_viewmodel.dart';

import 'package:superformula/features/generate/domain/entities/seed.dart';
import 'package:superformula/features/generate/domain/usecases/get_seed_usecase.dart';
import 'package:superformula/features/generate/presentation/viewmodels/generate_viewmodel.dart';

import 'package:superformula/core/errors/exceptions.dart';
import 'package:superformula/core/usecases/usecase.dart';

class MockGetSeedUseCase extends Mock implements GetSeedUsecase {}

void main() {
  final tSeed = Seed(
    seed: "seed",
    expiresAt: DateTime.parse('1979-11-12T13:10:42.240Z'),
  );
  group('states', () {
    MockGetSeedUseCase mockUseCase;
    GenerateViewModel tViewModel = GenerateViewModel(useCase: mockUseCase);

    setUp(() {
      mockUseCase = MockGetSeedUseCase();
      tViewModel = GenerateViewModel(useCase: mockUseCase);
    });
    test('Should have initial state', () {
      final expectedStatus = AppState.initial;
      expect(tViewModel.state, expectedStatus);
      assert(tViewModel.isInitial == true);
    });

    test('Should have pending state when performing request', () async {
      final expectedStatus = AppState.pending;
      tViewModel.getSeed();
      expect(tViewModel.state, expectedStatus);
      assert(tViewModel.isLoading == true);
    });

    test('Should have success state when request succeed', () async {
      when(mockUseCase(NoParams())).thenAnswer((_) async => tSeed);
      final expectedStatus = AppState.success;
      await tViewModel.getSeed();
      expect(tViewModel.state, expectedStatus);
      expect(tViewModel.seed, tSeed);
    });

    test('Should have failed state when request fail', () async {
      when(mockUseCase(NoParams())).thenThrow(ServerException());
      final expectedStatus = AppState.error;

      await tViewModel.getSeed();

      expect(tViewModel.state, expectedStatus);
    });
  });
}
