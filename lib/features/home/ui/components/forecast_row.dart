import 'package:flutter/material.dart';
import 'package:weather_app/features/home/ui/components/forecast_item.dart';
import 'package:weather_app/themes/app_font_styles.dart';

class ForecastRow extends StatelessWidget {
  final String title;

  const ForecastRow({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
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
          width: double.infinity,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black.withValues(alpha: .25),
          ),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 16, left: 20),
            separatorBuilder: (_, _) => const SizedBox(width: 16),
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return const ForecastItem();
            },
          ),
        ),
      ],
    );
  }
}
