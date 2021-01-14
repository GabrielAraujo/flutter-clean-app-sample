import 'package:flutter_riverpod/all.dart';
import 'package:superformula/core/providers/repository_providers.dart';

import 'package:superformula/features/generate/domain/usecases/get_seed_usecase.dart';

class UseCaseProviders {
  static final getSeedUseCase = Provider.autoDispose((ref) {
    final repository = ref.read(RepositoryProviders.getSeedRepository);
    return GetSeedUsecase(repository: repository);
  });
}
