import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../features/generate/presentation/pages/generate_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/scan/presentation/pages/scan_page.dart';
import 'app_routes.dart';

class RouteGenerator {
  static MaterialPageRoute generateRoutes(RouteSettings settings) =>
      MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) {
          switch (settings.name) {
            case AppRoutes.home:
              return HomePage();
            case AppRoutes.qrcode:
              return GeneratePage();
            case AppRoutes.scan:
              return ScanPage();
            default:
              return Container();
          }
        },
      );
}
