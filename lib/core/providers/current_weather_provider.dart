import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/data/model/current_weather_model.dart';
import 'package:weather_app/features/home/data/repository/current_weather_repository.dart';

final currentWeatherProvider =
    FutureProvider.family<CurrentWeatherModel, String>((ref, query) async {
      final repository = ref.read(currentWeatherRepositoryProvider);
      return repository.getCurrentWeather(query);
    });
