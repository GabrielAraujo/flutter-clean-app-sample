import 'package:flutter_riverpod/all.dart';
import 'package:superformula/core/providers/usecase_providers.dart';
import 'package:superformula/features/home/presentation/viewmodels/home_viewmodel.dart';

import 'package:superformula/features/generate/presentation/viewmodels/generate_viewmodel.dart';
import 'package:superformula/features/scan/presentation/viewmodels/scan_viewmodel.dart';

class ViewModelProviders {
  static final homeViewModel = Provider.autoDispose((ref) => HomeViewModel());
  static final generateViewModel = ChangeNotifierProvider.autoDispose((ref) {
    final useCase = ref.read(UseCaseProviders.getSeedUseCase);
    return GenerateViewModel(useCase: useCase);
  });
  static final scanViewModel = ChangeNotifierProvider.autoDispose((ref) {
    final useCase = ref.read(UseCaseProviders.validateSeedUseCase);
    return ScanViewModel(useCase: useCase);
  });
}
