import 'package:superformula/features/generate/data/models/seed_model.dart';

abstract class SeedRemoteDataSource {
  Future<SeedModel> getSeed();
}
