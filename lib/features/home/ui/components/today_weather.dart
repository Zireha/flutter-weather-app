import 'package:flutter/material.dart';
import 'package:weather_app/features/home/data/model/current_weather_model.dart';
import 'package:weather_app/themes/app_font_styles.dart';
import 'package:weather_app/utils/weather_theme.dart';

class TodayWeather extends StatelessWidget {
  final CurrentWeatherModel data;

  const TodayWeather({super.key, required this.data});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 16,
        children: [
          Icon(
            IconWeather().getWeatherIcon(
              data.current.condition.code,
              data.current.isDay == 1 ? true : false,
            ),
            size: 128,
            color: Colors.white,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("${data.current.tempC} C", style: AppFontStyles.boldHeader1),
              Row(
                children: [
                  Text("Feels like ", style: AppFontStyles.regularBody2),
                  Text(
                    "${data.current.feelslikeC} C",
                    style: AppFontStyles.boldBody2,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                data.current.condition.text,
                style: AppFontStyles.regularBody1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
