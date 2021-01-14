import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class AppException implements Exception {
  AppException();

  String getLocalizedMessage(BuildContext buildContext) {
    return AppLocalizations.of(buildContext).errorGenericMessage;
  }
}

class ServerException implements AppException {
  @override
  String getLocalizedMessage(BuildContext buildContext) {
    return getLocalizedMessage(buildContext);
  }
}

class InvalidSeedException implements AppException {
  @override
  String getLocalizedMessage(BuildContext buildContext) {
    return getLocalizedMessage(buildContext);
  }
}

class CacheException implements AppException {
  @override
  String getLocalizedMessage(BuildContext buildContext) {
    return getLocalizedMessage(buildContext);
  }
}
