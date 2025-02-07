import 'package:deepcaretask/domain/random_number.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('Random Number', () {
    test('random number is between 1 and 100', () {
      final number = RandomNumber(1).value;
      expect(number, isA<int>());
      expect(number >= 1 && number <= 100, true);
    });

    test('should return false for number 1 as it is not prime', () {
      expect(RandomNumber(1).isPrime(), false);
    });

    test('should return false if the number is not prime', () {
      final number = RandomNumber(8);
      expect(number.isPrime(), false);
    });
  });
}
