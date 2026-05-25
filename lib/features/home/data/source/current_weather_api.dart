import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/auth/secrets.dart';
import 'package:weather_app/core/global_providers/http_providers.dart';
import 'package:weather_app/features/home/data/model/current_weather_model.dart';

final currentWeatherApiProvider = Provider((ref) {
  final client = ref.read(httpClientProvider);
  return CurrentWeatherApi(client);
});

class CurrentWeatherApi {
  final Secrets secrets = Secrets();
  final http.Client client;
  CurrentWeatherApi(this.client);

  Future<CurrentWeatherModel> fetchCurrentWeather(String query) async {
    final url = Uri.parse(
      'http://api.weatherapi.com/v1/current.json?key=${secrets.weatherApiKey}&q=$query&aqi=no',
    );
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to get data from source");
    }
  }

  
}
