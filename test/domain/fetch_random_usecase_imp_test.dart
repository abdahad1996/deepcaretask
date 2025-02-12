import 'package:deepcaretask/domain/fetch_random_usecase_imp.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:deepcaretask/domain/random_number.dart';
import '../data/helpers/stub_random_number_repository.dart';


void main() {

  test('should return a RandomNumber when repository succeeds', () async {
    final stubRepository = StubRandomNumberRepository(
      stubbedNumber: RandomNumber(7),
    );
    final fetchRandomRepositoryImp = FetchRandomUsecaseImp(stubRepository);

     
    final result = await fetchRandomRepositoryImp.loadNumber();
     
    expect(result.value, 7); // Check the value of the random number
  });

  test('should throw an exception when repository fails', () async {
     
    final stubRepository = StubRandomNumberRepository(
      stubbedError: Exception('Repository Error'),
    );

    final fetchRandomRepositoryImp = FetchRandomUsecaseImp(stubRepository);

     
    expect(
      () => fetchRandomRepositoryImp.loadNumber(),
      throwsA(isA<Exception>()),
    );
  });
}
