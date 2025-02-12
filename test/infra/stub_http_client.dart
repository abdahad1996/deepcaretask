import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

class HttpClientStub implements http.Client {
  final String response;
  final int statusCode;
  final Exception? error;

  HttpClientStub({
    required this.response,
    this.statusCode = 200, // Default to 200 OK
    this.error,
  });

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    if (error != null) {
      throw error!;
    }
    return http.Response(response, statusCode);
  }

  // Implement remaining required methods with no-op implementations
  @override
  void close() {}

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    // TODO: implement readBytes
    throw UnimplementedError();
  }
}
