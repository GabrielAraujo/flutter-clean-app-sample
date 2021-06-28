import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../../../core/errors/exceptions.dart';

abstract class ValidateSeedRemoteDataSource {
  Future<bool> validateSeed(String seed);
}

class ValidateSeedRemoteDataSourceImpl implements ValidateSeedRemoteDataSource {
  final http.Client client;

  ValidateSeedRemoteDataSourceImpl({@required this.client});

  @override
  Future<bool> validateSeed(String seed) async {
    final response = await client.post(
        Uri.parse(
          'https://p0ivz4ffn9.execute-api.us-east-1.amazonaws.com/dev/seed/validate',
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"seed": seed}));

    if (response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 404) {
      throw InvalidSeedException();
    } else {
      throw ServerException();
    }
  }
}
