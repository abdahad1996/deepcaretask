import 'dart:io';

import 'package:deepcaretask/data/http/http_client.dart';
import 'package:deepcaretask/domain/random_number.dart';
import 'package:deepcaretask/data/remote_random_number.dart';
import 'package:deepcaretask/domain/random_number_repository.dart';

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
