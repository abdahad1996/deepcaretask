import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:deepcaretask/data/http/api_error.dart';
import 'package:deepcaretask/infra/api_client_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

/// **Stub class inheriting `http.Client`**
class HttpClientStub implements http.Client {
  final String response;
  final int statusCode;
  final Exception? error;

  HttpClientStub({
    required this.response,
    this.statusCode = 200,  // Default to 200 OK
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
  Future<http.Response> delete(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> patch(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
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


void main() {
  late ApiClientAdapter apiClientAdapter;
  late HttpClientStub httpClientStub;

  test('should return successful response when API returns valid data', () async {
    // Arrange
    const url = 'http://www.randomnumberapi.com/api/v1.0/random';
    final expectedResponse = jsonEncode([82]);
    httpClientStub = HttpClientStub(response: expectedResponse);
    apiClientAdapter = ApiClientAdapter(httpClientStub);

    // Act
    final result = await apiClientAdapter.getRequest(url: url);
    
    // Assert
    expect(result, expectedResponse);
  });

  test('should throw APIError.serverError when HttpClient throws an error',
      () async {
    // Arrange
    const url = 'http://www.randomnumberapi.com/api/v1.0/random';
    httpClientStub = HttpClientStub(
        response: '', error: SocketException('Failed to connect'));
    apiClientAdapter = ApiClientAdapter(httpClientStub);

    // Act & Assert
    expect(
      () => apiClientAdapter.getRequest(url: url),
      throwsA(APIError.serverError),
    );
  });

  test('should throw APIError.serverError for any other exception', () async {
    // Arrange
    const url = 'http://www.randomnumberapi.com/api/v1.0/random';
    httpClientStub =
        HttpClientStub(response: '', error: Exception('Unknown error'));
    apiClientAdapter = ApiClientAdapter(httpClientStub);

    // Act & Assert
    expect(
      () => apiClientAdapter.getRequest(url: url),
      throwsA(APIError.serverError),
    );
  });
}
