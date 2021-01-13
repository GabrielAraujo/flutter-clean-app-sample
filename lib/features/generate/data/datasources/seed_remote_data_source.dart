import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:superformula/core/errors/exceptions.dart';
import 'package:superformula/features/generate/data/models/seed_model.dart';

abstract class SeedRemoteDataSource {
  Future<SeedModel> getSeed();
}

class SeedRemoteDataSourceImpl implements SeedRemoteDataSource {
  final http.Client client;

  SeedRemoteDataSourceImpl({@required this.client});

  @override
  Future<SeedModel> getSeed() async {
    final response = await client.get(
      'https://1sf9yp4tea.execute-api.us-east-1.amazonaws.com/dev/seed',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return SeedModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
