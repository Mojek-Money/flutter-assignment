import '../entities/graph_data.dart';

/// Abstract interface for graph data operations
/// Defines the contract that any graph repository implementation must follow
abstract class GraphRepository {
  /// Fetches graph data from the data source
  /// Returns a Future<GraphData> containing expense information
  Future<GraphData> getGraphData();
} 