import 'package:flutter/cupertino.dart';
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
        return const LinearGradient(
          stops: [0.12, 0.62],
          colors: [Color(0xff74CCFF), Color(0xff0083D0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.daytimeCloudy:
        return const LinearGradient(
          stops: [0, 0.27, 0.59],
          colors: [Color(0xffB0C4DD), Color(0xff6595C0), Color(0xff4682B4)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.daytimeOvercast:
        return const LinearGradient(
          stops: [0, 0.41, 1],
          colors: [Color(0xffA9A9A9), Color(0xffB0C4DD), Color(0xff4682B4)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.daytimeRainyorSnowy:
        return const LinearGradient(
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
          colors: [
            const Color(0xff1A004E).withAlpha(207),
            const Color(0xff003B5E),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.nighttimeCloudy:
        return LinearGradient(
          stops: [0, 0.38],
          colors: [
            const Color(0xff636261).withAlpha(25),
            const Color(0xff003B5E),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.nighttimeOvercast:
        return LinearGradient(
          stops: [0.05, 0.3, 0.62],
          colors: [
            const Color(0xff787878).withAlpha(24),
            const Color(0xff49606E).withAlpha(138),
            const Color(0xff003B5E),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case WeatherCondition.nighttimeRainyorSnowy:
        return const LinearGradient(
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

class IconWeather {
  IconData getWeatherIcon(int code, bool isDay) {
    switch (code) {
      case 1000: // Sunny / Clear
        return isDay ? CupertinoIcons.sun_max : CupertinoIcons.moon_stars;

      case 1003: // Partly cloudy
        return isDay ? CupertinoIcons.cloud_sun : CupertinoIcons.cloud_moon;

      case 1006: // Cloudy
      case 1009: // Overcast
        return CupertinoIcons.cloud;

      case 1030: // Mist
      case 1135: // Fog
      case 1147: // Freezing fog
        return CupertinoIcons.cloud_fog;

      case 1063: // Patchy rain possible
      case 1180: // Patchy light rain
      case 1183: // Light rain
      case 1186: // Moderate rain at times
      case 1189: // Moderate rain
      case 1240: // Light rain shower
        return isDay
            ? CupertinoIcons.cloud_sun_rain
            : CupertinoIcons.cloud_moon_rain;

      case 1066: // Patchy snow possible
      case 1210: // Patchy light snow
      case 1213: // Light snow
      case 1216: // Patchy moderate snow
      case 1219: // Moderate snow
      case 1222: // Patchy heavy snow
      case 1225: // Heavy snow
      case 1255: // Light snow showers
      case 1258: // Moderate or heavy snow showers
        return CupertinoIcons.snow;

      case 1069: // Patchy sleet possible
      case 1072: // Patchy freezing drizzle possible
      case 1150: // Patchy light drizzle
      case 1153: // Light drizzle
      case 1168: // Freezing drizzle
      case 1171: // Heavy freezing drizzle
      case 1198: // Light freezing rain
      case 1201: // Moderate or heavy freezing rain
      case 1204: // Light sleet
      case 1207: // Moderate or heavy sleet
      case 1249: // Light sleet showers
      case 1252: // Moderate or heavy sleet showers
        return CupertinoIcons.cloud_sleet;

      case 1087: // Thundery outbreaks possible
      case 1273: // Patchy light rain with thunder
      case 1276: // Moderate or heavy rain with thunder
      case 1279: // Patchy light snow with thunder
      case 1282: // Moderate or heavy snow with thunder
        return CupertinoIcons.cloud_bolt_rain;

      case 1114: // Blowing snow
      case 1117: // Blizzard
        return CupertinoIcons.wind_snow;

      case 1192: // Heavy rain at times
      case 1195: // Heavy rain
      case 1243: // Moderate or heavy rain shower
      case 1246: // Torrential rain shower
        return CupertinoIcons.cloud_heavyrain;

      default:
        return CupertinoIcons.question_circle;
    }
  }
}
