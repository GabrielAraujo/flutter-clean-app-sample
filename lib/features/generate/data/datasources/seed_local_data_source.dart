import 'package:superformula/features/generate/data/models/seed_model.dart';

abstract class SeedLocalDataSource {
  Future<SeedModel> getLastSeed();
  Future<void> cacheSeed(SeedModel seedToCache);
}
