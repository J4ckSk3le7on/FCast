import 'package:dio/dio.dart';

extension ResultsExtension on Response {
  bool isSuccessful() {
    return this.statusCode < 300 && this.statusCode >= 200;
  }
}
