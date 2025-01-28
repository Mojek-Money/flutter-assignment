import '../../domain/repositories/home_repository.dart';
import '../../domain/entities/home_data.dart';

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<HomeData> getHomeData() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    return const HomeData(message: 'Welcome!');
  }
} 