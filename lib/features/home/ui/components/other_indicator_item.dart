import 'package:flutter/material.dart';
import 'package:weather_app/themes/app_font_styles.dart';

class OtherIndicatorItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const OtherIndicatorItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.black.withValues(alpha: .25),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 12,),
            SizedBox(
              width: 52,
              child: Icon(icon, size: 48, color: Colors.white),
            ),
            const SizedBox(width: 12,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    subtitle,
                    style: AppFontStyles.boldBody2,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    title,
                    style: AppFontStyles.regularSubtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
