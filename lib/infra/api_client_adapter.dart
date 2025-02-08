import 'package:http/http.dart' as http;

import 'package:deepcaretask/data/http/api_error.dart';
import 'package:deepcaretask/data/http/http_client.dart';

class ApiClientAdapter implements ApiClient {
  final http.Client client;

  ApiClientAdapter(this.client);
  @override
  Future<dynamic> getRequest({required String url}) async {
  
    try {
        final response = await client
          .get(Uri.parse(url));
          return response.body;
    } catch (error) {
      throw APIError.serverError;
    }
  }

}
