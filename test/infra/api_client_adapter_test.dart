import 'dart:convert';
import 'dart:io';
import 'package:deepcaretask/data/http/api_error.dart';
import 'package:deepcaretask/infra/api_client_adapter.dart';
import 'package:flutter_test/flutter_test.dart';

import 'stub_http_client.dart';



void main() {
  late ApiClientAdapter apiClientAdapter;
  late HttpClientStub httpClientStub;

  test('should return successful response when API returns valid data', () async {
     
    const url = 'http://www.randomnumberapi.com/api/v1.0/random';
    final expectedResponse = jsonEncode([82]);
    httpClientStub = HttpClientStub(response: expectedResponse);
    apiClientAdapter = ApiClientAdapter(httpClientStub);

     
    final result = await apiClientAdapter.getRequest(url: url);
    
    
    expect(result, jsonDecode(expectedResponse));
  });

  test('should throw APIError.serverError when HttpClient throws an error',
      () async {
     
    const url = 'http://www.randomnumberapi.com/api/v1.0/random';
    httpClientStub = HttpClientStub(
        response: '', error: SocketException('Failed to connect'));
    apiClientAdapter = ApiClientAdapter(httpClientStub);

     
    expect(
      () => apiClientAdapter.getRequest(url: url),
      throwsA(APIError.serverError),
    );
  });

  test('should throw APIError.serverError for any other exception', () async {
     
    const url = 'http://www.randomnumberapi.com/api/v1.0/random';
    httpClientStub =
        HttpClientStub(response: '', error: Exception('Unknown error'));
    apiClientAdapter = ApiClientAdapter(httpClientStub);

    expect(
      () => apiClientAdapter.getRequest(url: url),
      throwsA(APIError.serverError),
    );
  });
}
