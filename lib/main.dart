import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:superformula/app.dart';

import 'core/providers/global_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalProviders.init();
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}
