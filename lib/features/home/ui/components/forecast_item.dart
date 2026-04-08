import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/themes/app_font_styles.dart';

class ForecastItem extends StatelessWidget {
  const ForecastItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(CupertinoIcons.cloud_fill, size: 40, color: Colors.white),
        const SizedBox(height: 12),
        Text("24.2° C", style: AppFontStyles.boldSubtitle),
        Text("07.00", style: AppFontStyles.regularSubtitle),
      ],
    );
  }
}
