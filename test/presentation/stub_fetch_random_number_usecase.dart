import 'package:deepcaretask/domain/fetch_random_number_usecase.dart';
import 'package:deepcaretask/domain/random_number.dart';

class StubFetchRandomNumberUseCase implements FetchRandomNumberUseCase {
  final int numberToReturn;
  bool shouldFail;

  StubFetchRandomNumberUseCase({required this.numberToReturn, required this.shouldFail});

  @override
  Future<RandomNumber> loadNumber() async {
     if (shouldFail == true) {
      throw Exception();
    }
    return RandomNumber(numberToReturn);
  }
}
