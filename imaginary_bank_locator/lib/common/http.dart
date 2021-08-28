import 'dart:convert';

import 'package:http/http.dart' as baseHttp;

mixin Http {
  Future<T> get<T>(String url) async {
    return baseHttp
        .get(
      url,
    )
        .then((response) {
      if (response.statusCode == 204) {
        return null;
      }
      if (response.statusCode != 200) {
        throw HttpException('${response.statusCode}');
      }
      return jsonDecode(response.body) as T;
    });
  }
}

class HttpException implements Exception {
  final String message;
  HttpException(this.message);
  @override
  String toString() {
    return message;
  }
}
