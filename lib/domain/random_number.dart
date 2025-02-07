import 'dart:math';

class RandomNumber {
  final int value;

    RandomNumber(this.value);

  /// Determines if the number is prime.
  bool isPrime() {
    if (value < 2) return false;
    for (int i = 2; i <= value ~/ 2; i++) {
      if (value % i == 0) return false;
    }
    return true;
  }
}
