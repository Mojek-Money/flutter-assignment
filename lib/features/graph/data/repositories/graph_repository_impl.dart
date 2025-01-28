import '../../domain/repositories/graph_repository.dart';
import '../../domain/entities/graph_data.dart';
import 'dart:math';

/// Implementation of the GraphRepository interface
/// Handles data operations for the graph feature
class GraphRepositoryImpl implements GraphRepository {
  @override
  Future<GraphData> getGraphData() async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));
    
    final random = Random();
    final now = DateTime.now();

    // Generate 24 months of sample data
    final expenses = List<MonthlyExpense>.generate(
      24,
      (index) {
        // Calculate date for each month, going backwards from current month
        final date = DateTime(
          now.year,
          now.month - index,
          1,
        );
        // Generate random expense value between 1000 and 50000
        final value = 1000 + random.nextDouble() * 49000;
        return MonthlyExpense(date: date, value: value);
      },
    ).reversed.toList(); // Reverse to show oldest to newest

    return GraphData(
      expenses: expenses,
      title: 'Cashflow graph',
    );
  }
} 