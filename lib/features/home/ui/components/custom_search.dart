import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/features/home/domain/providers/suggestion_provider.dart';
import 'package:weather_app/features/home/domain/providers/today_forecast_provider.dart';
import 'package:weather_app/themes/app_font_styles.dart';

class CustomSearch extends ConsumerStatefulWidget {
  const CustomSearch({super.key});
  @override
  ConsumerState<CustomSearch> createState() => CustomSearchState();
}

class CustomSearchState extends ConsumerState<CustomSearch> {
  final SearchController controller = SearchController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: controller,
      headerHintStyle: const TextStyle(color: Colors.white),
      builder: (context, controller) {
        return GestureDetector(
          onTap: () {
            controller.openView();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: .25),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              children: [
                const SizedBox(width: 4),
                IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  alignment: Alignment.centerLeft,
                  onPressed: () {
                    controller.openView();
                  },
                ),
                Text("Find location", style: AppFontStyles.regularBody2),
              ],
            ),
          ),
        );
      },
      suggestionsBuilder: (context, controller) async {
        final query = controller.text.trim();
        if (query.isEmpty) {
          return const [
            Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text("Mulai mengetik untuk mendapatkan saran"),
              ),
            ),
          ];
        }

        await Future.delayed(const Duration(milliseconds: 500));
        if (query != controller.text.trim()) {
          return const [];
        }

        try {
          final data = await ref.read(suggestionProvider(query).future);

          if (data.isEmpty) {
            return const [ListTile(title: Text("Not Found"))];
          }

          return data
              .map(
                (datum) => ListTile(
                  title: Text("${datum.name}, ${datum.region}"),
                  subtitle: Text(datum.country),
                  onTap: () {
                    controller.closeView("");
                    ref.read(todayForecastProvider(datum.name));
                  },
                ),
              )
              .toList();
        } catch (e) {
          return [
            ListTile(
              title: const Text("Terjadi kesalahan koneksi"),
              subtitle: Text(e.toString()),
            ),
          ];
        }
      },
    );
  }
}
