import '../../../../core/base/base_view_model.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/usecases/get_home_data_usecase.dart';
import 'package:signals/signals.dart';

class HomeViewModel extends BaseViewModel {
  final GetHomeDataUseCase _getHomeDataUseCase;
  final homeData = signal<HomeData?>(null);

  HomeViewModel(this._getHomeDataUseCase);

  Future<void> loadHomeData() async {
    try {
      setLoading(true);
      homeData.value = await _getHomeDataUseCase.execute();
      setLoading(false);
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }
} 