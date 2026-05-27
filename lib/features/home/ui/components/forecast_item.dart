import 'package:flutter/material.dart';
import 'package:weather_app/themes/app_font_styles.dart';
import 'package:weather_app/utils/utils.dart';
import 'package:weather_app/utils/weather_theme.dart';

class ForecastItem extends StatelessWidget {
  final int code;
  final int isDay;
  final String tempC;
  final String timeLabel;
  final String dayLabel;
  final bool isWeekly;
  const ForecastItem({
    super.key,
    required this.code,
    required this.tempC,
    this.isDay = 1,
    this.isWeekly = false,
    this.timeLabel = "",
    this.dayLabel = "",
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          IconWeather().getWeatherIcon(code: code, isDay: isDay == 1 ? true : false),
          size: 40,
          color: Colors.white,
        ),
        const SizedBox(height: 12),
        Text("$tempC °C", style: AppFontStyles.boldSubtitle),
        Text(
          isWeekly
              ? TimeUtils().dateToDayConverter(dayLabel)
              : TimeUtils().timeExtractor(timeLabel),
          style: AppFontStyles.regularSubtitle,
        ),
      ],
    );
  }
}
