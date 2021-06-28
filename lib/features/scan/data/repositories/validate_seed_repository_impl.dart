import 'package:flutter/material.dart';

import '../../domain/repositories/validate_seed_repository.dart';
import '../datasources/validate_seed_remote_data_source.dart';

class ValidateSeedRepositoryImpl implements ValidateSeedRepository {
  final ValidateSeedRemoteDataSource remoteDataSource;

  ValidateSeedRepositoryImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<bool> validateSeed(String seed) async {
    return await remoteDataSource.validateSeed(seed);
  }
}
