// ignore_for_file: must_be_immutable, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/core/global_providers/location_provider.dart';
import 'package:weather_app/features/home/providers/current_weather_provider.dart';
import 'package:weather_app/features/home/providers/today_forecast_provider.dart';
import 'components/component_data.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/utils/weather_theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime? lastPressedAt;

    final locationAsync = ref.watch(locationProvider);

    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async => NavigationUtils()
            .onHomeBackPressed(context, didPop, result, lastPressedAt),
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: WeatherCondition.daytimeClear.gradient,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 20.0,
              ),
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
                                  return ForecastRow(
                                    title: "Today's Forecast",
                                    isHourly: true,
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
                                  return ForecastRow(
                                    title: "3 Days Forecast",
                                    isHourly: false,
                                    weeklyForecastItem:
                                        data.forecast.forecastday,
                                  );
                                },
                                error: (e, _) => const SizedBox(),
                                loading: () => const SizedBox(),
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
