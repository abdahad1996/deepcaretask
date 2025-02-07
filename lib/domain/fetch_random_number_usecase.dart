import 'package:deepcaretask/domain/random_number.dart';

abstract class FetchRandomNumberUseCase {
  Future<RandomNumber> loadNumber();
}

