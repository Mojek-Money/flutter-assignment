import 'package:get_it/get_it.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/get_home_data_usecase.dart';
import '../../features/home/presentation/viewmodels/home_viewmodel.dart';
import '../../features/graph/data/repositories/graph_repository_impl.dart';
import '../../features/graph/domain/repositories/graph_repository.dart';
import '../../features/graph/domain/usecases/get_graph_data_usecase.dart';
import '../../features/graph/presentation/viewmodels/graph_viewmodel.dart';

/// Global service locator instance for dependency injection
final getIt = GetIt.instance;

/// Initializes all dependencies in the application
/// This includes repositories, use cases, and view models
Future<void> setupServiceLocator() async {
  // Register services
  // getIt.registerSingleton<ApiService>(ApiService());
  
  // Register repositories
  // getIt.registerSingleton<UserRepository>(UserRepository(getIt<ApiService>()));
  
  // Register use cases
  // getIt.registerSingleton<GetUserUseCase>(GetUserUseCase(getIt<UserRepository>()));

  // Home Feature Dependencies
  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(),
  );
  getIt.registerLazySingleton(() => GetHomeDataUseCase(getIt()));
  getIt.registerLazySingleton(() => HomeViewModel(getIt()));

  // Graph Feature Dependencies
  getIt.registerLazySingleton<GraphRepository>(
    () => GraphRepositoryImpl(),
  );
  getIt.registerLazySingleton(() => GetGraphDataUseCase(getIt()));
  getIt.registerLazySingleton(() => GraphViewModel(getIt()));
} 