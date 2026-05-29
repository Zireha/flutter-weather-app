import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/data/model/search_suggestion_model.dart';
import 'package:weather_app/features/home/domain/repository/search_suggestion_repository.dart';

final suggestionProvider =
    FutureProvider.family<List<SearchLocationModel>, String>((
      ref,
      query,
    ) async {
      final repo = ref.watch(searchSuggestionRepository);
      return repo.getQuerySuggestion(query);
    });
