// ignore_for_file: must_be_immutable, dead_code

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weather_app/core/providers/current_weather_provider.dart';
import 'package:weather_app/core/providers/location_provider.dart';
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

                  return Stack(
                    children: [
                      // temp disable for code
                      // will activate later
                      // after ui dev
                      if (false)
                        WrapperScene(
                          sizeCanvas: const Size(350, 540),
                          isLeftCornerGradient: true,
                          colors: [],
                          children: [
                            RainWidget(
                              rainConfig: RainConfig(
                                count: 10,
                                lengthDrop: 12,
                                widthDrop: 2,
                                color: const Color.from(
                                  alpha: 0.6000,
                                  red: 0.4706,
                                  green: 0.5647,
                                  blue: 0.6118,
                                ),
                                isRoundedEndsDrop: true,
                                widgetRainDrop: null,
                                fallRangeMinDurMill: 0,
                                fallRangeMaxDurMill: 1000,
                                areaXStart: 20,
                                areaXEnd:
                                    MediaQuery.of(context).size.width - 20,
                                areaYStart: 40,
                                areaYEnd:
                                    MediaQuery.of(context).size.height * .75,
                                slideX: 2,
                                slideY: 0,
                                slideDurMill: 100,
                                slideCurve: const Cubic(0.40, 0.00, 0.20, 1.00),
                                fallCurve: const Cubic(0.55, 0.09, 0.68, 0.53),
                                fadeCurve: const Cubic(0.95, 0.05, 0.80, 0.04),
                              ),
                            ),
                          ],
                        ),
                      // main ui
                      SingleChildScrollView(
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
                                TodayWeather(
                                  iconUrl: data.current.condition.icon,
                                  condition: data.current.condition.text,
                                  currentTempinCelsius: data.current.tempC,
                                  currentTempFeelsLikeInCelsius:
                                      data.current.feelslikeC,
                                ),
                                const SizedBox(height: 60),
                                const ForecastRow(title: "Today's Forecast"),
                                const SizedBox(height: 20),
                                const ForecastRow(title: "7 Day Forecast"),
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
                          loading: () => const SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(child: CircularProgressIndicator()),
                              ],
                            ),
                          ),
                          error: (e, _) => SafeArea(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text("Error: $e")],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [Center(child: CircularProgressIndicator())],
                  ),
                ),
                error: (e, _) => SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Error: $e")],
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
