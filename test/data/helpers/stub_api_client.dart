
import 'package:deepcaretask/data/http/http_client.dart';

class APIClientStub implements ApiClient {
  final dynamic response;
  Exception? error;

  APIClientStub({this.response});

  @override
  Future<dynamic> getRequest({required String url}) async {
    if (error != null) {
      throw error!;
    }
    return response;
  }
}
