import 'package:flutter_riverpod/all.dart';

import '../../features/generate/domain/usecases/get_seed_usecase.dart';
import '../../features/scan/domain/usecases/validate_seed_usecase.dart';
import 'repository_providers.dart';

class UseCaseProviders {
  static final getSeedUseCase = Provider.autoDispose((ref) {
    final repository = ref.read(RepositoryProviders.getSeedRepository);
    return GetSeedUsecase(repository: repository);
  });
  static final validateSeedUseCase = Provider.autoDispose((ref) {
    final repository = ref.read(RepositoryProviders.validateSeedRepository);
    return ValidateSeedUsecase(repository: repository);
  });
}
