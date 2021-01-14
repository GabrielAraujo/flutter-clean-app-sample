import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:superformula/core/routing/app_routes.dart';
import 'package:superformula/features/home/presentation/pages/home_page.dart';

import 'package:superformula/features/generate/presentation/pages/generate_page.dart';

class RouteGenerator {
  static MaterialPageRoute generateRoutes(RouteSettings settings) =>
      MaterialPageRoute(
        settings: settings,
        // ignore: missing_return
        builder: (BuildContext context) {
          switch (settings.name) {
            case AppRoutes.home:
              return HomePage();
            case AppRoutes.qrcode:
              return GeneratePage();
            case AppRoutes.scan:
              return null;
            default:
              return Container();
          }
        },
      );
}
