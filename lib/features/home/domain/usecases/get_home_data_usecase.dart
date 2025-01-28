import '../repositories/home_repository.dart';
import '../entities/home_data.dart';

class GetHomeDataUseCase {
  final HomeRepository repository;

  GetHomeDataUseCase(this.repository);

  Future<HomeData> execute() async {
    return await repository.getHomeData();
  }
} 