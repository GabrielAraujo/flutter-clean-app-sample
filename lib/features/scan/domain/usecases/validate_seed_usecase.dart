import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/usecases/usecase.dart';
import '../repositories/validate_seed_repository.dart';

class ValidateSeedUsecase extends UseCase<bool, Params> {
  final ValidateSeedRepository repository;

  ValidateSeedUsecase({
    @required this.repository,
  });

  Future<bool> call(Params params) async {
    return await repository.validateSeed(params.seed);
  }
}

class Params extends Equatable {
  final String seed;

  Params({@required this.seed});

  @override
  List<Object> get props => [seed];
}
