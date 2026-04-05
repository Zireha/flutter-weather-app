import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/themes/app_font_styles.dart';

class DayAndLocation extends StatelessWidget {
  const DayAndLocation({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          spacing: 8,
          children: [
            Icon(CupertinoIcons.placemark_fill, color: Colors.white, size: 24),
            Text(
              "Surakarta, Central Java",
              style: AppFontStyles.regularBody2.copyWith(
                fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
        Column(
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "Monday",
              textAlign: TextAlign.end,
              style: AppFontStyles.regularHeader2.copyWith(
                fontWeight: FontWeight.w600
              ),
            ),
            Text(
              "September 3, 2026",
              textAlign: TextAlign.end,
              style: AppFontStyles.regularBody2.copyWith(
                fontWeight: FontWeight.w600
              ),
            ),
          ],
        ),
      ],
    );
  }
}
