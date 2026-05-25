import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/auth/secrets.dart';
import 'package:weather_app/core/global_providers/http_providers.dart';
import 'package:weather_app/features/home/data/model/forecast_model.dart';

final todayForecastApiProvider = Provider((ref) {
  final client = ref.read(httpClientProvider);
  return ForecastApi(client);
});

class ForecastApi {
  final Secrets secrets = Secrets();
  final http.Client client;
  ForecastApi(this.client);

  Future<ForecastModel> fetchTodayForecast({
    required String query,
    required String days,
  }) async {
    final url = Uri.parse(
      "http://api.weatherapi.com/v1/forecast.json?key=${secrets.weatherApiKey}&q=$query&days=$days&aqi=no&alerts=no",
    );
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return ForecastModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data from source");
    }
  }
}
