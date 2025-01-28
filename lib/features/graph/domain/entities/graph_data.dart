import 'package:equatable/equatable.dart';

/// Represents the complete data structure for the graph display
/// Contains a list of monthly expenses and a title
class GraphData extends Equatable {
  final List<MonthlyExpense> expenses;
  final String title;

  const GraphData({
    required this.expenses,
    required this.title,
  });

  @override
  List<Object?> get props => [expenses, title];
}

/// Represents a single data point in the graph
/// Contains the date and value for each expense entry
class MonthlyExpense extends Equatable {
  final DateTime date;
  final double value;

  const MonthlyExpense({
    required this.date,
    required this.value,
  });

  /// Formats the month name for display
  /// Returns in format "MMM YYYY" (e.g., "Jan 2024")
  String get monthName {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  @override
  List<Object?> get props => [date, value];
} 