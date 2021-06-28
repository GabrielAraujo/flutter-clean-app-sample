import '../entities/seed.dart';

abstract class GetSeedRepository {
  Future<Seed> getSeed();
}
