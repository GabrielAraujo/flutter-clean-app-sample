import 'package:flutter/material.dart';

enum AppState { initial, pending, error, success }

class BaseViewModel with ChangeNotifier {
  AppState _state = AppState.initial;

  AppState get state => _state;

  void setState(AppState state) {
    _state = state;
    notifyListeners();
  }

  bool get isInitial => _state == AppState.initial;
  bool get isLoading => _state == AppState.pending;
  bool get failed => _state == AppState.error;
  bool get succeeded => _state == AppState.success;
}
