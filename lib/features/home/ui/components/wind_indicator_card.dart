import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/themes/app_font_styles.dart';

class WindIndicatorCard extends StatelessWidget {
  final double windKph;
  final double windChillInCelsius;
  const WindIndicatorCard({
    super.key,
    required this.windKph,
    required this.windChillInCelsius
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.black.withValues(alpha: .25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 24,
        children: [
          const Icon(CupertinoIcons.wind, size: 72, color: Colors.white),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$windKph km/h", style: AppFontStyles.boldBody1),
              Text("Wind Speed", style: AppFontStyles.regularSubtitle),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$windChillInCelsius° C", style: AppFontStyles.boldBody1),
              Text("Wind Chill", style: AppFontStyles.regularSubtitle),
            ],
          ),
        ],
      ),
    );
  }
}
