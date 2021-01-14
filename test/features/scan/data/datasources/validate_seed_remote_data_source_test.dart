import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:superformula/core/errors/exceptions.dart';
import 'package:superformula/features/scan/data/datasources/validate_seed_remote_data_source.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  ValidateSeedRemoteDataSourceImpl dataSource;
  MockHttpClient mockHttpClient;

  void setUpMockHttpClientSuccess204(String seed) {
    when(
      mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: jsonEncode({
          "seed": seed,
        }),
      ),
    ).thenAnswer(
      (_) async => http.Response('', 204),
    );
  }

  void setUpMockHttpClientFailure404(String seed) {
    when(
      mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: jsonEncode({
          "seed": seed,
        }),
      ),
    ).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  void setUpMockHttpClientFailure504(String seed) {
    when(
      mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: jsonEncode({
          "seed": seed,
        }),
      ),
    ).thenAnswer(
      (_) async => http.Response('Something went wrong', 504),
    );
  }

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ValidateSeedRemoteDataSourceImpl(client: mockHttpClient);
  });

  group(
    'validateSeed',
    () {
      final tSeed = "seed";
      test(
        'should preform a POST request on a URL and with application/json header',
        () {
          //arrange
          setUpMockHttpClientSuccess204(tSeed);
          // act
          dataSource.validateSeed(tSeed);
          // assert
          verify(
            mockHttpClient.post(
              'https://p0ivz4ffn9.execute-api.us-east-1.amazonaws.com/dev/seed/validate',
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                "seed": tSeed,
              }),
            ),
          );
        },
      );

      test(
        'should return success when the response code is 204',
        () async {
          // arrange
          setUpMockHttpClientSuccess204(tSeed);
          // act
          final result = await dataSource.validateSeed(tSeed);
          // assert
          expect(result, true);
        },
      );

      test(
        'should throw a InvalidException when the response code is 404 or other',
        () async {
          // arrange
          setUpMockHttpClientFailure404(tSeed);
          // assert
          expect(() => dataSource.validateSeed(tSeed),
              throwsA(isA<InvalidSeedException>()));
        },
      );

      test(
        'should throw a ServerException when the response code is 504 or other',
        () async {
          // arrange
          setUpMockHttpClientFailure504(tSeed);
          // assert
          expect(() => dataSource.validateSeed(tSeed),
              throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
