
import 'package:deepcaretask/domain/random_number.dart';

class RemoteRandomNumberModel{
  final List<int> numbers;

  RemoteRandomNumberModel({
    required this.numbers,
  });

  /// Factory constructor to create a model from JSON
  factory RemoteRandomNumberModel.fromJson(dynamic json) {
    // Validate the JSON structure
    if (json is! List || json.length == 0 || json.any((item) => item is! int)) {
      throw Exception('Invalid data');
    }
    return RemoteRandomNumberModel(
      numbers: List<int>.from(json),
    );
  }

  /// Converts the model to the domain entity
  RandomNumber toEntity() {
    return RandomNumber(numbers.first);
  }
}
