import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import '../viewmodels/home_viewmodel.dart';
import '../../../../core/di/service_locator.dart';
import 'package:go_router/go_router.dart';

/// Main screen of the application that displays the home view
/// Contains navigation to graph screen and displays home data
/// Uses signals for state management via HomeViewModel

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<HomeViewModel>()..loadHomeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, 
          style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
          color: Colors.white,
        )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dynamic content section
              Watch((context) {
                if (_viewModel.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (_viewModel.errorMessage.value != null) {
                  return Center(child: Text(_viewModel.errorMessage.value!));
                }
                // Button to navigate to the graph screen which displays 
                // a bar chart visualization of monthly expenses

                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () => context.go('/graph'),
                      child: const Text(
                        'Go to Assignment',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              
              const SizedBox(height: 24),
              
              // Project explanation section
              const Text(
                'Project architecture details',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              _buildExplanationCard(
                'Initialization Flow',
                'The app starts by setting up dependencies through ServiceLocator, '
                'registering repositories, use cases, and ViewModels.',
              ),
              
              _buildExplanationCard(
                'Clean Architecture Layers',
                '• Presentation Layer: Screens & ViewModels\n'
                '• Domain Layer: Entities, Repository Interfaces & Use Cases\n'
                '• Data Layer: Repository Implementations & Models',
              ),
              
              _buildExplanationCard(
                'Data Flow',
                '1. Screen requests data through ViewModel\n'
                '2. ViewModel calls Use Case\n'
                '3. Use Case works with Repository\n'
                '4. Repository fetches data from API and returns data\n'
                '5. UI updates automatically via signals',
              ),
              
              _buildExplanationCard(
                'State Management',
                'Uses signals for reactive state management.\n'
                'Loading states and errors are handled through BaseViewModel.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExplanationCard(String title, String content) {
    return Card(
      color: Theme.of(context).colorScheme.tertiary,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 