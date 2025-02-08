import 'package:deepcaretask/data/remote_random_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/stub_api_client.dart';


void main() {
  const testUrl = 'http://www.randomnumberapi.com/api/v1.0/random';


  test('should return RandomNumber when APIClient returns valid JSON',
      () async {
    // Arrange
    final apiClientStub = APIClientStub(response: [42]);
    final repository = RemoteRandomNumberRepository(apiClientStub, testUrl);

    // Act
    final result = await repository.loadNumber();

    // Assert
    expect(result.value, 42); // Check the RandomNumber value
  });

  test('should throw Exception when APIClient throws an error', () async {
    // Arrange
    final apiClientStub = APIClientStub(response: [42]);
    final repository = RemoteRandomNumberRepository(apiClientStub, testUrl);
    apiClientStub.error = Exception('API Error');

    // Act & Assert
    expect(() => repository.loadNumber(), throwsA(isA<Exception>()));
  });

  test('should throw Exception when APIClient returns invalid JSON', () async {
    // Arrange
    final apiClientStub = APIClientStub(response: [42]);
    final repository = RemoteRandomNumberRepository(apiClientStub, testUrl);
    apiClientStub.error = Exception('invaliddata');

    // Act & Assert
    expect(() => repository.loadNumber(), throwsA(isA<Exception>()));
  });
}
