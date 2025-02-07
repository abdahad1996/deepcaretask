import 'package:deepcaretask/data/fetch_random_usecase_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deepcaretask/domain/random_number.dart';
import 'helpers/stub_random_number_repository.dart';


void main() {
  // late FetchRandomRepositoryImp fetchRandomRepositoryImp;

  test('should return a RandomNumber when repository succeeds', () async {
    // Arrange
    final stubRepository = StubRandomNumberRepository(
      stubbedNumber: RandomNumber(7),
    );
    final fetchRandomRepositoryImp = FetchRandomUsecaseImp(stubRepository);

    // Act
    final result = await fetchRandomRepositoryImp.loadNumber();
    // Assert
    expect(result.value, 7); // Check the value of the random number
  });

  test('should throw an exception when repository fails', () async {
    // Arrange
    final stubRepository = StubRandomNumberRepository(
      stubbedError: Exception('Repository Error'),
    );

    final fetchRandomRepositoryImp = FetchRandomUsecaseImp(stubRepository);

    // Act & Assert
    expect(
      () => fetchRandomRepositoryImp.loadNumber(),
      throwsA(isA<Exception>()),
    );
  });
}
