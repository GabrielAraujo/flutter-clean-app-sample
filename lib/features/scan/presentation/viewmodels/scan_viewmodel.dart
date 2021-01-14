import 'package:flutter/material.dart';
import 'package:superformula/core/errors/exceptions.dart';
import 'package:superformula/core/viewmodels/base_viewmodel.dart';
import 'package:superformula/features/scan/domain/usecases/validate_seed_usecase.dart';

class ScanViewModel extends BaseViewModel {
  final ValidateSeedUsecase useCase;
  String _seed;
  String _message = "Scan a QRCode";

  ScanViewModel({
    @required this.useCase,
  });

  String get seed => _seed;
  setSeed(String newSeed) {
    if (newSeed != _seed) {
      _seed = newSeed;
      validateSeed(newSeed);
    }
  }

  String get message => _message;
  setMessage(String newMessage) {
    _message = newMessage;
  }

  Future<void> validateSeed(String seed) async {
    try {
      setState(AppState.pending);
      await useCase(Params(seed: seed));
      setMessage(seed + "\n is valid");
      setState(AppState.success);
    } on AppException catch (ex) {
      if (ex is InvalidSeedException) {
        setMessage("This is not a valid seed.");
      } else {
        setMessage("Sorry, this QRCode could not be validated.");
      }
      setState(AppState.error);
    }
    return;
  }
}
