import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/data/model/current_weather_model.dart';
import 'package:weather_app/features/home/providers/repository/current_weather_repository.dart';
import 'package:weather_app/features/home/providers/theme_provider.dart';

final currentWeatherProvider =
    FutureProvider.family<CurrentWeatherModel, String>((ref, query) async {
      final repository = ref.watch(currentWeatherRepositoryProvider);
      final weatherData = await repository.getCurrentWeather(query);

      ref.read(isDayProvider.notifier).state = weatherData.current.isDay;
      ref.read(weatherCodeProvider.notifier).state =
          weatherData.current.condition.code;

      return weatherData;
    });
