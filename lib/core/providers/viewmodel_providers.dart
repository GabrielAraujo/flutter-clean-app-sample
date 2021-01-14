import 'package:flutter_riverpod/all.dart';
import 'package:superformula/features/home/presentation/viewmodels/home_viewmodel.dart';

class ViewModelProviders {
  static final homeViewModel = Provider.autoDispose((ref) => HomeViewModel());
}
