
import 'package:deepcaretask/data/http/http_client.dart';
import 'package:deepcaretask/data/http/remote_random_number.dart';
import 'package:deepcaretask/domain/random_number.dart';
import 'package:deepcaretask/domain/random_number_repository.dart';

class RandomNumberRepositoryImp implements RandomNumberRepository {
  final ApiClient _apiClient;
  final String url;

  RandomNumberRepositoryImp(this._apiClient, this.url);

  @override
  Future<RandomNumber> loadNumber() async {
    // get number from api
    final json = await _apiClient.getRequest(url: url);
    // parse json to random number
    final remoteRandomNumber = RemoteRandomNumberModel.fromJson(json);
    // return random number
    return remoteRandomNumber.toEntity();
  }
}
