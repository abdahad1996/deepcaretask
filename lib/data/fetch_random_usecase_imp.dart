import 'package:deepcaretask/domain/fetch_random_number_usecase.dart';
import 'package:deepcaretask/domain/random_number.dart';
import 'package:deepcaretask/domain/random_number_repository.dart';

class FetchRandomUsecaseImp implements FetchRandomNumberUseCase {
  final RandomNumberRepository _repository;

  FetchRandomUsecaseImp(this._repository);

  @override
  Future<RandomNumber> loadNumber() async {
    return await _repository.loadNumber();
  }
}
