import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/features/home/ui/components/other_indicator_item.dart';

class OtherIndicator extends StatelessWidget {
  const OtherIndicator({super.key});
  @override
  Widget build(BuildContext context) {
    return const Column(
      spacing: 12,
      children: [
        Row(
          spacing: 8,
          children: [
            OtherIndicatorItem(
              icon: CupertinoIcons.eye_fill,
              subtitle: "10 km",
              title: "Visibility",
            ),
            OtherIndicatorItem(
              icon: CupertinoIcons.drop_fill,
              subtitle: "78%",
              title: "Humidity",
            ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            OtherIndicatorItem(
              icon: CupertinoIcons.cloud_rain,
              subtitle: "0.03mm",
              title: "Precipitation",
            ),
            OtherIndicatorItem(
              icon: CupertinoIcons.rays,
              subtitle: "7,3",
              title: "UV Rays",
            ),
          ],
        )
      ],
    );
  }
}