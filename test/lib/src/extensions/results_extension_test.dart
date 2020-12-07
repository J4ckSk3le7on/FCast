import 'package:dio/dio.dart';
import 'package:f_cast/src/extensions/results_extension.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockResponse extends Mock implements Response {}

void main() {
  MockResponse mockResponse;

  setUp(() {
    mockResponse = MockResponse();
  });

  group("results", () {
    test("When status is 200, true is returned", () {
      //arrange
      when(mockResponse.statusCode).thenReturn(200);

      //act
      var result = mockResponse.isSuccessful();

      //assert
      expect(result, true);
    });

    test("When status is 500, true is returned", () {
      //arrange
      when(mockResponse.statusCode).thenReturn(500);

      //act
      var result = mockResponse.isSuccessful();

      //assert
      expect(result, false);
    });
  });
}
