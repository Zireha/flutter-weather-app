import 'package:flutter/material.dart';
import 'package:weather_app/features/home/data/model/forecast_model.dart';
import 'package:weather_app/themes/app_font_styles.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/utils/weather_theme.dart';

class WeeklyForecast extends StatelessWidget {
  final List<Forecastday> weeklyForecastItem;

  const WeeklyForecast({super.key, required this.weeklyForecastItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          "3 Day Forecast",
          style: AppFontStyles.regularBody2.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemCount: weeklyForecastItem.length,
          itemBuilder: (context, index) {
            final item = weeklyForecastItem[index];

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(75),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    TimeUtils().dateToDayConverter(item.date.toIso8601String()),
                    style: AppFontStyles.regularBody1,
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      Text(
                        "${item.day.avgtempC.toString()} °C",
                        style: AppFontStyles.regularBody1,
                      ),
                      Icon(
                        IconWeather().getWeatherIcon(
                          code: item.day.condition.code,
                          isDay: true,
                        ),
                        size: 40,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
