// ignore_for_file: must_be_immutable, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/global_providers/location_provider.dart';
import 'package:weather_app/features/home/providers/current_weather_provider.dart';
import 'package:weather_app/features/home/providers/today_forecast_provider.dart';
import 'package:weather_app/features/home/ui/components/weekly_forecast.dart';
import 'package:weather_app/themes/app_font_styles.dart';
import 'components/component_data.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/utils/weather_theme.dart';
import 'package:weather_app/features/home/providers/theme_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime? lastPressedAt;

    final locationAsync = ref.watch(locationProvider);
    final isDayState = ref.watch(isDayProvider);
    final weatherCodeState = ref.watch(weatherCodeProvider);

    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async => NavigationUtils()
            .onHomeBackPressed(context, didPop, result, lastPressedAt),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: BackgroundTheme().getBackgroundGradient(
              weatherCodeState,
              isDayState,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: locationAsync.when(
                data: (position) {
                  final query = "${position.latitude}, ${position.longitude}";
                  final weatherAsync = ref.watch(currentWeatherProvider(query));
                  final todayForecast = ref.watch(todayForecastProvider(query));
                  final threeDayForecast = ref.watch(
                    threeDaysForecastProvider(query),
                  );

                  return RefreshIndicator(
                    onRefresh: () async {
                      try {
                        await Future.wait([
                          ref.refresh(currentWeatherProvider(query).future),
                          ref.refresh(todayForecastProvider(query).future),
                        ]);
                      } catch (_) {}
                    },
                    child: SingleChildScrollView(
                      child: weatherAsync.when(
                        data: (data) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CustomSearch(),
                              const SizedBox(height: 16),
                              DayAndLocation(
                                city: data.location.name,
                                region: data.location.region,
                                date: data.location.localtime,
                              ),
                              const SizedBox(height: 52),
                              TodayWeather(data: data),
                              const SizedBox(height: 60),
                              // today forecast
                              todayForecast.when(
                                data: (data) {
                                  return DailyForecastRow(
                                    title: "Today's Forecast",
                                    hourlyForecastItem:
                                        data.forecast.forecastday.first.hour,
                                  );
                                },
                                error: (e, _) => Text(e.toString()),
                                loading: () => const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              threeDayForecast.when(
                                data: (data) {
                                  return WeeklyForecast(
                                    weeklyForecastItem:
                                        data.forecast.forecastday,
                                  );
                                },
                                error: (e, _) => Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(75),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    e.toString(),
                                    style: AppFontStyles.regularBody2.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                loading: () => Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(75),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              WindIndicatorCard(
                                windKph: data.current.windKph,
                                windChillInCelsius: data.current.windchillC,
                              ),
                              const SizedBox(height: 16),
                              OtherIndicator(
                                humidity: data.current.humidity,
                                precipitation: data.current.precipMm,
                                uv: data.current.uv,
                                visibility: data.current.visKm,
                              ),
                              const SizedBox(height: 12.0),
                            ],
                          );
                        },
                        loading: () => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        error: (e, _) => SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Center(
                            child: Text(
                              "Error: $e",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                loading: () => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                error: (e, _) => Center(
                  child: Text(
                    "Error: $e",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
