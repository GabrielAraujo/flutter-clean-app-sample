import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:superformula/core/routing/app_routes.dart';

abstract class MenuItem {
  final String destination = AppRoutes.root;
  String title(BuildContext context);
  IconData icon();
}

class ScanMenuItem implements MenuItem {
  @override
  IconData icon() => Icons.radio_button_checked;

  @override
  String title(BuildContext context) =>
      AppLocalizations.of(context).scanMenuTitle;

  @override
  final String destination = AppRoutes.scan;
}

class QRCodeMenuItem implements MenuItem {
  @override
  IconData icon() => Icons.radio_button_checked;

  @override
  String title(BuildContext context) =>
      AppLocalizations.of(context).qrCodeMenuTitle;

  @override
  final String destination = AppRoutes.qrcode;
}
