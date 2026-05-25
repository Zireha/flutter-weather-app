import 'package:flutter/cupertino.dart';
import 'package:weather_app/features/home/ui/components/other_indicator_item.dart';

class OtherIndicator extends StatelessWidget {
  final double visibility;
  final int humidity;
  final double precipitation;
  final double uv;

  const OtherIndicator({
    super.key,
    required this.visibility,
    required this.humidity,
    required this.precipitation,
    required this.uv,
  });
  
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        Row(
          spacing: 8,
          children: [
            OtherIndicatorItem(
              icon: CupertinoIcons.eye_fill,
              subtitle: "$visibility km",
              title: "Visibility",
            ),
            OtherIndicatorItem(
              icon: CupertinoIcons.drop_fill,
              subtitle: "$humidity%",
              title: "Humidity",
            ),
          ],
        ),
        Row(
          spacing: 8,
          children: [
            OtherIndicatorItem(
              icon: CupertinoIcons.cloud_rain,
              subtitle: "${precipitation}mm",
              title: "Precipitation",
            ),
            OtherIndicatorItem(
              icon: CupertinoIcons.rays,
              subtitle: "$uv",
              title: "UV Rays",
            ),
          ],
        ),
      ],
    );
  }
}
