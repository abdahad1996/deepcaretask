
import 'fetch_random_number_usecase.dart';
import 'random_number.dart';
import 'random_number_repository.dart';

class FetchRandomUsecaseImp implements FetchRandomNumberUseCase {
  final RandomNumberRepository _repository;

  FetchRandomUsecaseImp(this._repository);

  @override
  Future<RandomNumber> loadNumber() async {
    return await _repository.loadNumber();
  }
}
