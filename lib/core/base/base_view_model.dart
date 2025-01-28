import 'package:signals/signals.dart';

abstract class BaseViewModel {
  final isLoading = signal<bool>(false);
  final errorMessage = signal<String?>(null);

  void setLoading(bool loading) {
    isLoading.value = loading;
  }

  void setError(String? error) {
    errorMessage.value = error;
  }
} 