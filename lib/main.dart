import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:superformula/app.dart';

void main() {
  runApp(
    ProviderScope(
      child: App(),
    ),
  );
}
