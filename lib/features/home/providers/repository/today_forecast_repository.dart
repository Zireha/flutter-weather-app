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
    final secondDayData = await api.fetchTodayForecast(query: query, days: "2");
    /*
      this line of code was written by LLM (Gemini 3.1) (And this comment was
      written by me, not AI itself)

      as for my future self, this line of code is the usage of time epoch provided
      from API utilized for filtering weather from current time until 23.00 or
      11 PM (e.g, if current time is 7 AM then it will show all weather prediction
      from 7 AM to 11 PM or 23.00)

     */
    final currentLocalTimeEpoch = data.location.localtimeEpoch;

    final filteredHours = data.forecast.forecastday.first.hour.where((hour) {
      return hour.timeEpoch >= (currentLocalTimeEpoch - 3600);
    }).toList();

    final remainingHours = 24 - filteredHours.length;
    /*

      the logic was simple, you only need to take both data in 24 hours, then
      filter the first data between current hour until 23:00. Then take the next
      data from 00:00 to an hour before current time.

      basically the next day hours is 24 minus the length of first data

      man I do really need to use my brain more

     */
    final secondFilteredHours = secondDayData.forecast.forecastday[1].hour
        .take(remainingHours)
        .toList();


    data.forecast.forecastday.first.hour = [
      ...filteredHours,
      ...secondFilteredHours,
    ];

    return data;
  }
}
