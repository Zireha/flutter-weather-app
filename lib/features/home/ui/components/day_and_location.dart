import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/themes/app_font_styles.dart';
import 'package:weather_app/utils/utils.dart';

class DayAndLocation extends StatelessWidget {
  final String city;
  final String region;
  final String date;
  const DayAndLocation({super.key, required this.city, required this.region, required this.date});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          spacing: 8,
          children: [
            const Icon(
              CupertinoIcons.placemark_fill,
              color: Colors.white,
              size: 24,
            ),
            Text(
              "$city, $region",
              style: AppFontStyles.regularBody2.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        Column(
          spacing: 2,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              TimeUtils().dateToDayConverter(date),
              textAlign: TextAlign.end,
              style: AppFontStyles.regularHeader2.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              TimeUtils().dateExtractor(date),
              textAlign: TextAlign.end,
              style: AppFontStyles.regularBody2.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
