import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/data/model/forecast_model.dart';
import 'package:weather_app/features/home/domain/providers/theme_provider.dart';
import 'package:weather_app/themes/app_font_styles.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/utils/weather_theme.dart';

class ThreeDayForecastScreen extends ConsumerWidget {
  final List<Hour> hourlyForecastItem;

  const ThreeDayForecastScreen({super.key, required this.hourlyForecastItem});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherCode = ref.watch(weatherCodeProvider);
    final isDayState = ref.watch(isDayProvider);

    return Scaffold(
      backgroundColor: Colors.black, // Mencegah flash putih saat transisi
      extendBodyBehindAppBar:
          true, // Memastikan gradient ditarik sampai ke belakang AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: BackgroundTheme().getBackgroundGradient(
            weatherCode,
            isDayState,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            child: Column(
              spacing: 12,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Next 24 Hour Weather Prediction",
                  style: AppFontStyles.boldHeader2,
                ),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (_, _) => const SizedBox(height: 8),
                    itemCount: hourlyForecastItem.length,
                    itemBuilder: (context, index) {
                      final item = hourlyForecastItem[index];

                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(75),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                spacing: 16,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  // Time
                                  SizedBox(
                                    width:
                                        60, // Fixed width agar icon sejajar vertikal
                                    child: Text(
                                      TimeUtils().timeExtractor(item.time),
                                      style: AppFontStyles.regularBody1,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  // Icon Weather
                                  Icon(
                                    IconWeather().getWeatherIcon(
                                      code: item.condition.code,
                                      isDay: item.isDay == 1 ? true : false,
                                    ),
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                  // weather condition
                                  Expanded(
                                    child: Text(
                                      item.condition.text,
                                      style: AppFontStyles.regularBody1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ), // Jarak aman dengan teks suhu
                            // weather degree
                            Text(
                              "${item.tempC} °C",
                              style: AppFontStyles.boldBody1,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
