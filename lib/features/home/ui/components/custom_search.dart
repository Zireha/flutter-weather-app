import 'package:flutter/material.dart';
import 'package:weather_app/themes/app_font_styles.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});
  @override
  State<CustomSearch> createState() => CustomSearchState();
}

class CustomSearchState extends State<CustomSearch> {
  final SearchController controller = SearchController();

  @override
  Widget build(BuildContext context) {
    return SearchAnchor(
      searchController: controller,
      headerHintStyle: TextStyle(color: Colors.white),
      builder: (context, controller) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: .25),
            backgroundBlendMode: BlendMode.multiply,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            children: [
              SizedBox(width: 4),
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
        );
      },
      suggestionsBuilder: (context, controller) {
        return List<ListTile>.generate(3, (int index) {
          final String item = "item $index";
          return ListTile(
            title: Text(
              item,
              style: AppFontStyles.regularBody2.copyWith(color: Colors.black87),
            ),
            onTap: () {
              setState(() {
                controller.closeView(item);
              });
            },
          );
        });
      },
    );
  }
}
