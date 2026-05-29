import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/data/model/current_weather_model.dart';
import 'package:weather_app/features/home/domain/repository/current_weather_repository.dart';
import 'package:weather_app/features/home/domain/providers/theme_provider.dart';

/*
  Provider: part which used to obtain data fetched from data layer and managing
  or manipulating data that is shown in UI
 */

final currentWeatherProvider = FutureProvider.family<CurrentWeatherModel, String>((
  ref,
  query,
) async {
  final repository = ref.watch(currentWeatherRepositoryProvider);
  final weatherData = await repository.getCurrentWeather(query);

  Future.microtask(() {
    ref.read(isDayProvider.notifier).state = weatherData.current.isDay;
    ref.read(weatherCodeProvider.notifier).state =
        weatherData.current.condition.code;
  });

  return weatherData;
});
