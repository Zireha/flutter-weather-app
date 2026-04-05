import 'package:flutter/painting.dart';

enum WeatherCondition {
  daytimeClear,
  daytimeCloudy,
  daytimeOvercast,
  daytimeRainyorSnowy,
  nighttimeClear,
  nighttimeCloudy,
  nighttimeOvercast,
  nighttimeRainyorSnowy,
}

extension WeatherTheme on WeatherCondition {
  LinearGradient get gradient {
    switch (this) {
      case WeatherCondition.daytimeClear:
        return LinearGradient(
          stops: [0.12, 0.62],
          colors: [Color(0xff74CCFF), Color(0xff0083D0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.daytimeCloudy:
        return LinearGradient(
          stops: [0, 0.27, 0.59],
          colors: [Color(0xffB0C4DD), Color(0xff6595C0), Color(0xff4682B4)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.daytimeOvercast:
        return LinearGradient(
          stops: [0, 0.41, 1],
          colors: [Color(0xffA9A9A9), Color(0xffB0C4DD), Color(0xff4682B4)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.daytimeRainyorSnowy:
        return LinearGradient(
          stops: [0, 0.22, 0.42, 1],
          colors: [
            Color(0xffA9A9A9),
            Color(0xffB0C4DD),
            Color(0xff6E8995),
            Color(0xff2E3B4F),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.nighttimeClear:
        return LinearGradient(
          stops: [0, 0.72],
          colors: [Color(0xff1A004E).withAlpha(207), Color(0xff003B5E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.nighttimeCloudy:
        return LinearGradient(
          stops: [0, 0.38],
          colors: [Color(0xff636261).withAlpha(25), Color(0xff003B5E)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.nighttimeOvercast:
        return LinearGradient(
          stops: [0.05, 0.3, 0.62],
          colors: [
            Color(0xff787878).withAlpha(24),
            Color(0xff49606E).withAlpha(138),
            Color(0xff003B5E),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.nighttimeRainyorSnowy:
        return LinearGradient(
          stops: [0.1, 0.34, 0.57, 0.89],
          colors: [
            Color(0xff364251),
            Color(0xff364251),
            Color(0xff1F3340),
            Color(0xff21262B),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }
}
