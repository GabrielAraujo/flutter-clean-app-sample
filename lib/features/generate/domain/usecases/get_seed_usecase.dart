import 'package:flutter/material.dart';
import 'package:superformula/core/usecases/usecase.dart';
import 'package:superformula/features/generate/domain/entities/seed.dart';
import 'package:superformula/features/generate/domain/repositories/get_seed_repository.dart';

class GetSeedUsecase extends UseCase<Seed, NoParams> {
  final GetSeedRepository repository;

  GetSeedUsecase({
    @required this.repository,
  });

  Future<Seed> call(NoParams params) async {
    return await repository.getSeed();
  }
}
