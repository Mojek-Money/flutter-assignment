import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import '../viewmodels/graph_viewmodel.dart';
import '../../../../core/di/service_locator.dart';
import 'package:go_router/go_router.dart';

/// Screen that displays the expense graph
/// Uses fl_chart to render bar chart visualization
class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  late final GraphViewModel _viewModel;
  final ScrollController _scrollController = ScrollController();

  /// Formats currency values for display
  /// Returns values in format ₹X.XL for lakhs or ₹X.XK for thousands
  String formatCurrency(double value) {
    if (value >= 100000) {
      return '₹${(value / 100000).toStringAsFixed(1)}L';
    } else if (value >= 1000) {
      return '₹${(value / 1000).toStringAsFixed(1)}K';
    } else {
      return '₹${value.toStringAsFixed(0)}';
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize and load data when screen is created
    _viewModel = getIt<GraphViewModel>()..loadGraphData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Handle back navigation
      onPopInvokedWithResult: (didPop, result) async {
        if (context.canPop()) {
          context.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Fix the graph", 
          style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        )),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // Navigate back or to home screen
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/');
              }
            },
          ),
        ),
        // Watch for changes in the view model's state
        body: Watch((context) {
          // Show loading indicator while data is being fetched
          if (_viewModel.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error message if any
          if (_viewModel.errorMessage.value != null) {
            return Center(child: Text(_viewModel.errorMessage.value!));
          }

          final data = _viewModel.graphData.value;
          if (data == null) {
            return const Center(child: Text('No data available'));
          }

          // Build the graph UI
          return Column(
            children: [
              // Graph title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  data.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              // Bar chart container
              SizedBox(
                height: 500,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BarChart(
                    BarChartData(
                      // Configure chart dimensions and scales
                      maxY: data.expenses.map((e) => e.value).reduce((a, b) => a > b ? a : b),
                      minY: 0,
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              if (value.toInt() >= 0 && 
                                  value.toInt() < data.expenses.length) {
                                final date = data.expenses[value.toInt()].date;
                                final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                             'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                                final monthYear = "${months[date.month - 1]}'${date.year.toString().substring(2)}";
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Transform.rotate(
                                    angle: -0.5,
                                    child: Text(
                                      monthYear,
                                      style: const TextStyle(
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return const Text('');
                            },
                            reservedSize: 40,
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 60,
                            getTitlesWidget: (value, meta) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  formatCurrency(value),
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: const FlGridData(
                        show: true,
                        drawVerticalLine: false,
                      ),
                      borderData: FlBorderData(show: false),
                      // Create bar groups from expense data
                      barGroups: data.expenses.asMap().entries.map((entry) {
                        return BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            BarChartRodData(
                              toY: entry.value.value,
                              color: Theme.of(context).colorScheme.secondary,
                              width: 10,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6),
                              ),
                            ),
                          ],
                          barsSpace: 20,
                        );
                      }).toList(),
                      extraLinesData: ExtraLinesData(horizontalLines: []),
                      groupsSpace: 30,
                      alignment: BarChartAlignment.end,
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 150),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
} 