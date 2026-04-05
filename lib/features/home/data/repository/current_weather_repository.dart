import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/data/model/current_weather_model.dart';
import 'package:weather_app/features/home/data/source/current_weather_api.dart';

final currentWeatherRepositoryProvider = Provider((ref) {
  final dataSource = ref.read(currentWeatherApiProvider);
  return CurrentWeatherRepository(dataSource);
});

class CurrentWeatherRepository {
  final CurrentWeatherApi dataSource;
  CurrentWeatherRepository(this.dataSource);

  Future<CurrentWeatherModel> getCurrentWeather(String query) {
    return dataSource.fetchCurrentWeather(query);
  }
}
