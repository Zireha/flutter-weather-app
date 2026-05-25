import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class TimeUtils {
  String dateToDayConverter(String date) {
    String dayName = DateFormat('EEEE').format(DateTime.parse(date));
    return dayName;
  }

  String dateExtractor(String date) {
    String fullDate = DateFormat("yMMMMd").format(DateTime.parse(date));
    return fullDate;
  }

  String timeExtractor(String data) {
    final parsed = DateTime.parse(data);
    String hour = DateFormat("HH:mm").format(parsed);

    return hour;
  }
}

class NavigationUtils {
  Toastification toastification = Toastification();

  void onHomeBackPressed(
    BuildContext context,
    bool didPop,
    Object? result,
    DateTime? lastPressedAt,
  ) {
    if (didPop) return;

    final now = DateTime.now();
    final backButtonIsPressedOrTooOld =
        lastPressedAt == null ||
        now.difference(lastPressedAt) > const Duration(seconds: 2);

    if (backButtonIsPressedOrTooOld) {
      lastPressedAt = now;

      toastification.show(
        context: context,
        type: ToastificationType.info,
        style: ToastificationStyle.simple,
        title: const Text(
          "Tekan sekali lagi untuk keluar",
          style: TextStyle(color: Colors.black45, fontWeight: FontWeight.w500),
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
  }
}
