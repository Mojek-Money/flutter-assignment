import '../repositories/graph_repository.dart';
import '../entities/graph_data.dart';

/// Use case for retrieving graph data
/// Acts as an intermediary between the ViewModel and Repository
class GetGraphDataUseCase {
  final GraphRepository repository;

  GetGraphDataUseCase(this.repository);

  /// Executes the use case to fetch graph data
  /// Returns a Future<GraphData> containing the graph information
  Future<GraphData> execute() async {
    return await repository.getGraphData();
  }
} 