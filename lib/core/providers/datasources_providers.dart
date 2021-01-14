import 'package:flutter_riverpod/all.dart';

import 'package:superformula/features/generate/data/datasources/seed_local_data_source.dart';
import 'package:superformula/features/generate/data/datasources/seed_remote_data_source.dart';
import 'package:superformula/features/scan/data/datasources/validate_seed_remote_data_source.dart';

import 'global_providers.dart';

class RemoteDataSourcesProviders {
  static final getSeedDataSource = Provider.autoDispose((ref) {
    final client = ref.read(GlobalProviders.httpClient);
    return SeedRemoteDataSourceImpl(client: client);
  });
  static final validateSeedDataSource = Provider.autoDispose((ref) {
    final client = ref.read(GlobalProviders.httpClient);
    return ValidateSeedRemoteDataSourceImpl(client: client);
  });
}

class LocalDataSourcesProviders {
  static final getSeedDataSource = Provider.autoDispose((ref) =>
      SeedLocalDataSourceImpl(
          sharedPreferences: GlobalProviders.sharedPreferences));
}
