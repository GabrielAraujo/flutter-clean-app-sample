import 'package:flutter_riverpod/all.dart';

import '../../features/generate/presentation/viewmodels/generate_viewmodel.dart';
import '../../features/home/presentation/viewmodels/home_viewmodel.dart';
import '../../features/scan/presentation/viewmodels/scan_viewmodel.dart';
import 'usecase_providers.dart';

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
