import 'package:flutter/widgets.dart';
import 'package:superformula/core/network/network_info.dart';
import 'package:superformula/features/generate/data/datasources/seed_local_data_source.dart';
import 'package:superformula/features/generate/data/datasources/seed_remote_data_source.dart';
import 'package:superformula/features/generate/domain/entities/seed.dart';
import 'package:superformula/features/generate/domain/repositories/get_seed_repository.dart';

class GetSeedRepositoryImpl implements GetSeedRepository {
  final SeedRemoteDataSource remoteDataSource;
  final SeedLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GetSeedRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Seed> getSeed() async {
    if (await networkInfo.isConnected) {
      final remoteSeed = await remoteDataSource.getSeed();
      localDataSource.cacheSeed(remoteSeed);
      return remoteSeed;
    } else {
      final localSeed = await localDataSource.getLastSeed();
      return localSeed;
    }
  }
}
