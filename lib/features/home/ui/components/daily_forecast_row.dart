import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/data/model/forecast_model.dart';
import 'package:weather_app/features/home/ui/components/forecast_item.dart';
import 'package:weather_app/features/three_days_forecast/ui/three_day_forecast_screen.dart';
import 'package:weather_app/themes/app_font_styles.dart';

class DailyForecastRow extends ConsumerWidget {
  final String title;
  final List<Hour> hourlyForecastItem;

  const DailyForecastRow({
    super.key,
    required this.title,
    required this.hourlyForecastItem,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppFontStyles.regularBody2.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThreeDayForecastScreen(
                    hourlyForecastItem: hourlyForecastItem,
                  ),
                ),
              ),
              child: Text(
                "See more",
                style: AppFontStyles.regularBody2.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withAlpha(75),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SizedBox(
            height: 120,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
              separatorBuilder: (_, _) => const SizedBox(width: 16),
              scrollDirection: Axis.horizontal,
              itemCount: hourlyForecastItem.length,
              itemBuilder: (context, index) {
                final itemHourly = hourlyForecastItem[index];
                return ForecastItem(
                  code: itemHourly.condition.code,
                  isDay: itemHourly.isDay,
                  tempC: itemHourly.tempC.toString(),
                  timeLabel: itemHourly.time,
                  isWeekly: false,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
