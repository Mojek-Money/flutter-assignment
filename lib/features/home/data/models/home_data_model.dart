import '../../domain/entities/home_data.dart';

class HomeDataModel extends HomeData {
  const HomeDataModel({required String message}) : super(message: message);

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      message: json['message'] as String,
    );
  }
} 