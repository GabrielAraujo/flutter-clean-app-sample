import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

abstract class MenuItem {
  final String type = "MenuItem";
  String title(BuildContext context);
  IconData icon();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuItem &&
          runtimeType == other.runtimeType &&
          type == other.type;

  @override
  int get hashCode => type.hashCode;
}

class ScanMenuItem implements MenuItem {
  @override
  IconData icon() => Icons.radio_button_checked;

  @override
  String title(BuildContext context) =>
      AppLocalizations.of(context).scanMenuTitle;

  @override
  final String type = "ScanMenuItem";
}

class QRCodeMenuItem implements MenuItem {
  @override
  IconData icon() => Icons.radio_button_checked;

  @override
  String title(BuildContext context) =>
      AppLocalizations.of(context).qrCodeMenuTitle;

  @override
  final String type = "QRCodeMenuItem";
}
