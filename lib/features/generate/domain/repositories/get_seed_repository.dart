import 'package:superformula/features/generate/domain/entities/seed.dart';

abstract class GetSeedRepository {
  Future<Seed> getSeed();
}
