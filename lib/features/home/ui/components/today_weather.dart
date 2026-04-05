import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/themes/app_font_styles.dart';

class TodayWeather extends StatelessWidget {
  const TodayWeather({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(CupertinoIcons.sun_max_fill, color: Colors.amber, size: 120),
        SizedBox(width: 28),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("29.0° C", style: AppFontStyles.boldHeader1),
            Row(
              children: [
                Text(
                  "Feels like ",
                  style: AppFontStyles.regularBody2,
                ),
                Text(
                  "30.6° C",
                  style: AppFontStyles.boldBody2,
                ),
              ],
            ),
            SizedBox(height: 4,),
            Text("Sunny", style: AppFontStyles.regularHeader2,)
          ],
        ),
      ],
    );
  }
}
