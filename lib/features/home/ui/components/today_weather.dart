import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/themes/app_font_styles.dart';

class TodayWeather extends StatelessWidget {
  final double currentTempinCelsius;
  final double currentTempFeelsLikeInCelsius;
  final String condition;
  final String iconUrl;

  const TodayWeather({
    super.key,
    required this.currentTempinCelsius,
    required this.currentTempFeelsLikeInCelsius,
    required this.condition,
    required this.iconUrl
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            "https:${iconUrl.replaceAll("64x64", "128x128")}",
            scale: .7,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("$currentTempinCelsius C", style: AppFontStyles.boldHeader1),
              Row(
                children: [
                  Text("Feels like ", style: AppFontStyles.regularBody2),
                  Text(
                    "$currentTempFeelsLikeInCelsius° C",
                    style: AppFontStyles.boldBody2,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(condition, style: AppFontStyles.regularBody1.copyWith(
                fontSize: 20
              )),
            ],
          ),
          const SizedBox(width: 12,)
        ],
      ),
    );
  }
}
