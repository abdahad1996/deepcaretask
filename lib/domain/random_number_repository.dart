
import 'random_number.dart';

abstract class RandomNumberRepository {
  Future<RandomNumber> loadNumber();
}
