import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:deepcaretask/data/http/api_error.dart';
import 'package:deepcaretask/data/http/http_client.dart';

class ApiClientAdapter implements ApiClient {
  final http.Client client;

  ApiClientAdapter(this.client);
  
  @override
  Future<dynamic> getRequest({required String url}) async {
    try {
      final response = await client.get(
        Uri.parse("https://www.randomnumberapi.com/api/v1.0/random"),);
      return  jsonDecode(response.body);
    } catch (error) {
      throw APIError.serverError;
    }
  }
}
