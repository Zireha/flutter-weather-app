import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/data/model/forecast_model.dart';
import 'package:weather_app/features/home/data/source/forecast_api.dart';

final todayForecastRepositoryProvider = Provider((ref) {
  final data = ref.read(todayForecastApiProvider);
  return TodayForecastRepository(data);
});

class TodayForecastRepository {
  final ForecastApi api;
  TodayForecastRepository(this.api);

  Future<ForecastModel> getTodayForecast({
    required String query,
    String days = "1",
  }) async {
    final data = await api.fetchTodayForecast(days: days, query: query);

    final currentLocalTimeEpoch = data.location.localtimeEpoch;

    final filteredHours = data.forecast.forecastday.first.hour.where((hour) {
      return hour.timeEpoch >= (currentLocalTimeEpoch - 3600);
    }).toList();

    data.forecast.forecastday.first.hour = filteredHours;

    return data;
  }
}
