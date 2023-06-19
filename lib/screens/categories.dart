import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/category.dart';
import 'package:meals/model/meals.dart';
import 'package:meals/screens/meal.dart';
import 'package:meals/widgets/categories_grid_items.dart';

class CategoriesUI extends StatelessWidget {
  const CategoriesUI(
      {super.key,
      // required this.onToggleFavorites,
      required this.availableMeal});

  // final void Function(Meal meal) onToggleFavorites;
  final List<Meal> availableMeal;

  void _navigatorScreen(BuildContext context, Category category) {
    final filteredList = availableMeal.where((element) {
      return element.categories.contains(category.id);
    }).toList();
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return MealsScreen(
          title: category.title,
          meals: filteredList,
          // onToggleFavorites: onToggleFavorites,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (var element in availableCategory)
            CategoriesGridItems(
              category: element,
              onSelectedCategory: () {
                _navigatorScreen(context, element);
              },
            )
        ],
      ),
    );
  }
}
