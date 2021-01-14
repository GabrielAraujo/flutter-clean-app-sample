import 'dart:async';

import 'package:flutter/material.dart';
import 'package:superformula/core/viewmodels/base_viewmodel.dart';

import 'package:superformula/core/usecases/usecase.dart';
import 'package:superformula/features/generate/domain/entities/seed.dart';
import 'package:superformula/features/generate/domain/usecases/get_seed_usecase.dart';

class GenerateViewModel extends BaseViewModel {
  final GetSeedUsecase useCase;
  Timer _timer;
  Seed _seed;
  int _seconds;

  GenerateViewModel({
    @required this.useCase,
  });

  Seed get seed => _seed;
  setSeed(Seed newSeed) {
    _seed = newSeed;
    _rebuildTimer(newSeed.expiresAt);
  }

  String get seconds => _seconds?.toString() ?? "calculating..";
  setSeconds(int newSeconds) {
    _seconds = newSeconds;
    notifyListeners();
  }

  Future<void> getSeed() async {
    try {
      setState(AppState.pending);
      final Seed seed = await useCase(NoParams());
      setSeed(seed);
      setState(AppState.success);
    } catch (ex) {
      setState(AppState.error);
      print(ex);
    }
    return;
  }

  _rebuildTimer(DateTime expiresAt) {
    final now = DateTime.now().toUtc();
    final seconds = expiresAt.difference(now).inSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int countdown = seconds - timer.tick;
      if (countdown == 0) {
        setSeconds(null);
        getSeed();
        timer.cancel();
      } else {
        setSeconds(countdown);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
