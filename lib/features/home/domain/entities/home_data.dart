import 'package:equatable/equatable.dart';

class HomeData extends Equatable {
  final String message;

  const HomeData({required this.message});

  @override
  List<Object?> get props => [message];
} 