import 'package:deepcaretask/domain/random_number.dart';

abstract class RandomNumberRepository {
  Future<RandomNumber> loadNumber();
}
