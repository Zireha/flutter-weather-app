import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/auth/secrets.dart';
import 'package:weather_app/core/global_providers/http_providers.dart';
import 'package:weather_app/features/home/data/model/current_weather_model.dart';
import 'package:weather_app/features/home/data/model/forecast_model.dart';
import 'package:weather_app/features/home/data/model/search_suggestion_model.dart';

final currentWeatherApiProvider = Provider((ref) {
  final client = ref.read(httpClientProvider);
  return CurrentWeatherApi(client);
});

class CurrentWeatherApi {
  final http.Client client;
  CurrentWeatherApi(this.client);

  Future<CurrentWeatherModel> fetchCurrentWeather(String query) async {
    final url = Uri.parse(
      'http://api.weatherapi.com/v1/current.json?key=${Secrets().weatherApiKey}&q=$query&aqi=no',
    );
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return CurrentWeatherModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to get data from source");
    }
  }

  Future<ForecastModel> fetchTodayForecast({
    required String query,
    required String days,
  }) async {
    final url = Uri.parse(
      "http://api.weatherapi.com/v1/forecast.json?key=${Secrets().weatherApiKey}&q=$query&days=$days&aqi=no&alerts=no",
    );
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return ForecastModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch data from source");
    }
  }

  Future<List<SearchLocationModel>> fetchSearchSuggestion({
    required String query,
  }) async {
    final response = await http.get(
      Uri.parse(
        "http://api.weatherapi.com/v1/search.json?key=${Secrets().weatherApiKey}&q=$query",
      ),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((data) => SearchLocationModel.fromJson(data)).toList();
    } else {
      throw Exception("Failed to fetch data from source");
    }
  }
}
