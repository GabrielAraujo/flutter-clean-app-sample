import 'package:flutter/material.dart';

import '../../../../core/usecases/usecase.dart';
import '../entities/seed.dart';
import '../repositories/get_seed_repository.dart';

class GetSeedUsecase extends UseCase<Seed, NoParams> {
  final GetSeedRepository repository;

  GetSeedUsecase({
    @required this.repository,
  });

  Future<Seed> call(NoParams params) async {
    return await repository.getSeed();
  }
}
