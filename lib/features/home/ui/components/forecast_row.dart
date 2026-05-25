import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/data/model/forecast_model.dart';
import 'package:weather_app/features/home/ui/components/forecast_item.dart';
import 'package:weather_app/themes/app_font_styles.dart';

class ForecastRow extends ConsumerWidget {
  final String title;
  final bool isHourly;
  final List<Hour> hourlyForecastItem;
  final List<Forecastday> weeklyForecastItem;

  const ForecastRow({
    super.key,
    required this.title,
    this.isHourly = true,
    this.hourlyForecastItem = const [],
    this.weeklyForecastItem = const [],
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
            Text(
              "See more",
              style: AppFontStyles.regularBody2.copyWith(
                fontWeight: FontWeight.w700,
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
            child: isHourly
                ? ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 16, left: 12),
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
                  )
                : Center(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(top: 16, left: 12),
                      separatorBuilder: (_, _) => const SizedBox(width: 32),
                      scrollDirection: Axis.horizontal,
                      itemCount: weeklyForecastItem.length,
                      itemBuilder: (context, index) {
                        final itemDaily = weeklyForecastItem[index];

                        return ForecastItem(
                          code: itemDaily.day.condition.code,
                          tempC: itemDaily.day.avgtempC.toString(),
                          dayLabel: itemDaily.date.toIso8601String(),
                          isWeekly: true,
                        );
                      },
                    ),
                  ),
          ),
        ),
      ],
    );
  }
}
