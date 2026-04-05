// ignore_for_file: must_be_immutable, dead_code

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toastification/toastification.dart';
import 'package:weather_animation/weather_animation.dart';
import 'package:weather_app/features/home/ui/components/custom_search.dart';
import 'package:weather_app/features/home/ui/components/day_and_location.dart';
import 'package:weather_app/features/home/ui/components/forecast_row.dart';
import 'package:weather_app/features/home/ui/components/other_indicator.dart';
import 'package:weather_app/features/home/ui/components/today_weather.dart';
import 'package:weather_app/features/home/ui/components/wind_indicator_card.dart';
import 'package:weather_app/utils/weather_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressedAt;
    Toastification toastification = Toastification();

    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) return;

          final now = DateTime.now();
          final backButtonIsPressedOrTooOld =
              lastPressedAt == null ||
              now.difference(lastPressedAt!) > Duration(seconds: 2);

          if (backButtonIsPressedOrTooOld) {
            lastPressedAt = now;

            toastification.show(
              context: context,
              type: ToastificationType.info,
              style: ToastificationStyle.simple,
              title: const Text(
                "Tekan sekali lagi untuk keluar",
                style: TextStyle(
                  color: Colors.black45,
                  fontWeight: FontWeight.w500,
                ),
              ),
              alignment: Alignment.bottomCenter,
              autoCloseDuration: const Duration(seconds: 3),
              dragToClose: true,
              dismissDirection: DismissDirection.down,
              closeButtonShowType: CloseButtonShowType.none,
              showIcon: false,
            );
          } else {
            SystemNavigator.pop();
          }
        },
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: WeatherCondition.daytimeClear.gradient,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 16.0,
              ),
              child: Stack(
                children: [
                  // temp disable for code
                  // will activate later
                  // after ui dev
                  if (false)
                    WrapperScene(
                      sizeCanvas: Size(350, 540),
                      isLeftCornerGradient: true,
                      colors: [],
                      children: [
                        RainWidget(
                          rainConfig: RainConfig(
                            count: 10,
                            lengthDrop: 12,
                            widthDrop: 2,
                            color: const Color.from(
                              alpha: 0.6000,
                              red: 0.4706,
                              green: 0.5647,
                              blue: 0.6118,
                            ),
                            isRoundedEndsDrop: true,
                            widgetRainDrop: null,
                            fallRangeMinDurMill: 0,
                            fallRangeMaxDurMill: 1000,
                            areaXStart: 20,
                            areaXEnd: MediaQuery.of(context).size.width - 20,
                            areaYStart: 40,
                            areaYEnd: MediaQuery.of(context).size.height * .75,
                            slideX: 2,
                            slideY: 0,
                            slideDurMill: 100,
                            slideCurve: const Cubic(0.40, 0.00, 0.20, 1.00),
                            fallCurve: const Cubic(0.55, 0.09, 0.68, 0.53),
                            fadeCurve: const Cubic(0.95, 0.05, 0.80, 0.04),
                          ),
                        ),
                      ],
                    ),
                  // main ui
                  const SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomSearch(),
                        SizedBox(height: 16),
                        DayAndLocation(),
                        SizedBox(height: 52),
                        Center(child: TodayWeather()),
                        SizedBox(height: 60),
                        ForecastRow(title: "Today's Forecast"),
                        SizedBox(height: 20),
                        ForecastRow(title: "5 Day Forecast"),
                        SizedBox(height: 24),
                        WindIndicatorCard(),
                        SizedBox(height: 16,),
                        OtherIndicator()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
