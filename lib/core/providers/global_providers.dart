import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:superformula/core/network/network_info.dart';

class GlobalProviders {
  static final networkInfo =
      Provider.autoDispose((ref) => NetworkInfoImpl(DataConnectionChecker()));
  static final httpClient = Provider.autoDispose((ref) => http.Client());

  static SharedPreferences sharedPreferences;
  static Future init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
