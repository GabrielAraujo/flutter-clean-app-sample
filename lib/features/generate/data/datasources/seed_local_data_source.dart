import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/seed_model.dart';

abstract class SeedLocalDataSource {
  Future<SeedModel> getLastSeed();
  Future<void> cacheSeed(SeedModel seedToCache);
}

const CACHED_SEED = 'CACHED_SEED';

class SeedLocalDataSourceImpl implements SeedLocalDataSource {
  final SharedPreferences sharedPreferences;

  SeedLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<SeedModel> getLastSeed() {
    final jsonString = sharedPreferences.getString(CACHED_SEED);
    if (jsonString != null) {
      return Future.value(SeedModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheSeed(SeedModel seedToCache) {
    return sharedPreferences.setString(
      CACHED_SEED,
      json.encode(seedToCache.toJson()),
    );
  }
}
