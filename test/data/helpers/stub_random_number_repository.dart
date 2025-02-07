import 'package:deepcaretask/domain/random_number.dart';
import 'package:deepcaretask/domain/random_number_repository.dart';

class StubRandomNumberRepository implements RandomNumberRepository {
  final RandomNumber? stubbedNumber;
  final Exception? stubbedError;

  StubRandomNumberRepository({this.stubbedNumber, this.stubbedError});

  @override
  Future<RandomNumber> loadNumber() async {
    if (stubbedError != null) {
      throw stubbedError!;
    }
    return Future.value(stubbedNumber);
  }
}
