import '../../../../core/base/base_view_model.dart';
import '../../domain/entities/graph_data.dart';
import '../../domain/usecases/get_graph_data_usecase.dart';
import 'package:signals/signals.dart';

/// ViewModel for the graph screen
/// Manages the state and business logic for the graph display
class GraphViewModel extends BaseViewModel {
  final GetGraphDataUseCase _getGraphDataUseCase;
  
  /// Signal to hold and notify graph data changes
  final graphData = signal<GraphData?>(null);

  GraphViewModel(this._getGraphDataUseCase);

  /// Loads graph data from the use case
  /// Updates loading state and handles errors
  Future<void> loadGraphData() async {
    try {
      setLoading(true);
      graphData.value = await _getGraphDataUseCase.execute();
      setLoading(false);
    } catch (e) {
      setError(e.toString());
      setLoading(false);
    }
  }
} 