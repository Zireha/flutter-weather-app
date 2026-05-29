import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/data/model/search_suggestion_model.dart';
import 'package:weather_app/features/home/data/source/current_weather_api.dart';

final searchSuggestionRepository = Provider((ref) {
  final dataSource = ref.read(currentWeatherApiProvider);
  return SearchSuggestionRepository(dataSource);
});

class SearchSuggestionRepository {
  final CurrentWeatherApi dataSource;
  SearchSuggestionRepository(this.dataSource);

  Future<List<SearchLocationModel>> getQuerySuggestion(String query) {
    return dataSource.fetchSearchSuggestion(query: query);
  }
}
