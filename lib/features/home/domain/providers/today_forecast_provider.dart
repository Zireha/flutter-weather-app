import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/data/model/forecast_model.dart';
import 'package:weather_app/features/home/domain/repository/today_forecast_repository.dart';

final todayForecastProvider = FutureProvider.family<ForecastModel, String>((
  ref,
  query,
) {
  final repo = ref.watch(todayForecastRepositoryProvider);
  return repo.getTodayForecast(query: query);
});

final threeDaysForecastProvider = FutureProvider.family<ForecastModel, String>((
  ref,
  query,
) {
  final repo = ref.watch(todayForecastRepositoryProvider);
  return repo.getTodayForecast(query: query, days: "3");
});
