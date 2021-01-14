import 'package:flutter_riverpod/all.dart';
import 'package:superformula/core/providers/datasources_providers.dart';

import 'package:superformula/features/generate/data/repositories/get_seed_repository_impl.dart';
import 'package:superformula/features/scan/data/repositories/validate_seed_repository_impl.dart';
import 'package:superformula/features/scan/domain/repositories/validate_seed_repository.dart';

import 'global_providers.dart';

class RepositoryProviders {
  static final getSeedRepository = Provider.autoDispose((ref) {
    final remoteDataSource =
        ref.read(RemoteDataSourcesProviders.getSeedDataSource);
    final localDataSource =
        ref.read(LocalDataSourcesProviders.getSeedDataSource);
    final networkInfo = ref.read(GlobalProviders.networkInfo);
    return GetSeedRepositoryImpl(
      remoteDataSource: remoteDataSource,
      localDataSource: localDataSource,
      networkInfo: networkInfo,
    );
  });

  static final validateSeedRepository = Provider.autoDispose((ref) {
    final remoteDataSource =
        ref.read(RemoteDataSourcesProviders.validateSeedDataSource);
    return ValidateSeedRepositoryImpl(
      remoteDataSource: remoteDataSource,
    );
  });
}
