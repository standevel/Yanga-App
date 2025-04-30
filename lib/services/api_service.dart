import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:yanga/api_response.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<YangaApiResponse<T>> makeRequest<T>(
      String endpoint, T Function(Object? json) fromJsonT,
      {String method = "GET", Map<String, dynamic>? body}) async {
    final Uri url = Uri.parse("$baseUrl$endpoint");

    final response = http.Request(method, url)
      ..headers.addAll({"Content-Type": "application/json"})
      ..body = (body != null ? jsonEncode(body) : null)!;

    final streamedResponse = await http.Client().send(response);
    final responseBody = await streamedResponse.stream.bytesToString();
    print('responseBody: $responseBody');
    final decodedJson = jsonDecode(responseBody);

    return YangaApiResponse<T>.fromJson(decodedJson, fromJsonT);
  }
}
