import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class AppException implements Exception {
  String message;

  AppException({this.message});

  String getLocalizedMessage(BuildContext buildContext) {
    return AppLocalizations.of(buildContext).errorGenericMessage;
  }

  @override
  String toString() {
    if (message == null) return super.toString();
    return "$message";
  }
}
