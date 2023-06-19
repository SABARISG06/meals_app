import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Providers/favorite_provider.dart';
import 'package:meals/Providers/filters_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filter_screen.dart';
import 'package:meals/screens/meal.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:meals/Providers/meals_provider.dart';

const kSelectingFliter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarianFree: false,
  Filter.veganFree: false,
};

class BottomTab extends ConsumerStatefulWidget {
  const BottomTab({super.key});

  @override
  ConsumerState<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends ConsumerState<BottomTab> {
  int _currentSelectedIndex = 0;
  // final List<Meal> _favoritesMeals = [];

  // Map<Filter, bool> _selectedFilter = kSelectingFliter;

  // void _showSnakeBars(String message) {
  //   ScaffoldMessenger.of(context).clearSnackBars;
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text(message)),
  //   );
  // } moving to the meals detail screen

  // void _addAndRemoveMeals(Meal meal) {
  //   final isExisting = _favoritesMeals.contains(meal);
  //   if (isExisting) {
  //     setState(() {
  //       _favoritesMeals.remove(meal);
  //     });
  //     _showSnakeBars('${meal.title} is Removed successfully');
  //   } else {
  //     setState(() {
  //       _favoritesMeals.add(meal);
  //     });
  //     _showSnakeBars('${meal.title} is added successfully');
  //   }
  // }

  void _selectPage(int index) {
    setState(() {
      _currentSelectedIndex = index;
    });
  }

  void _setScreen(String identifiers) async {
    Navigator.of(context).pop();
    if (identifiers == 'Filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) {
            return const FilterScreen(
                // currentFilters: _selectedFilter,
                );
          },
        ),
      );
      // _selectedFilter = result ?? kSelectingFliter;
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filterMealsProvider);
    Widget activeScreen = CategoriesUI(
      // onToggleFavorites: _addAndRemoveMeals,
      availableMeal: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_currentSelectedIndex == 1) {
      final favoriteMeals = ref.watch(favoriteMealsProviders);
      activeScreen = MealsScreen(
        meals: favoriteMeals,
        // onToggleFavorites: _addAndRemoveMeals,
      );
      activePageTitle = 'Favorites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activeScreen,
      drawer: MainDrawer(onSelectedScreen: _setScreen),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          _selectPage(value);
        },
        currentIndex: _currentSelectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
