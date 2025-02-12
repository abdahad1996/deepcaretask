import 'package:deepcaretask/data/http/random_repository_imp.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/stub_api_client.dart';


void main() {
  const testUrl = 'http://www.randomnumberapi.com/api/v1.0/random';


  test('should return RandomNumber when APIClient returns valid JSON',
      () async {
    final apiClientStub = APIClientStub(response: [42]);
    final repository = RandomNumberRepositoryImp(apiClientStub, testUrl);

    final result = await repository.loadNumber();

    expect(result.value, 42); 
  });

  test('should throw Exception when APIClient throws an error', () async {
    final apiClientStub = APIClientStub(response: [42]);
    final repository = RandomNumberRepositoryImp(apiClientStub, testUrl);
    apiClientStub.error = Exception('API Error');

    expect(() => repository.loadNumber(), throwsA(isA<Exception>()));
  });

  test('should throw Exception when APIClient returns invalid JSON', () async {
    final apiClientStub = APIClientStub(response: [42]);
    final repository = RandomNumberRepositoryImp(apiClientStub, testUrl);
    apiClientStub.error = Exception('invaliddata');

    expect(() => repository.loadNumber(), throwsA(isA<Exception>()));
  });
}
