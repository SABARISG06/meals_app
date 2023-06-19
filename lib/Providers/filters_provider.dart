import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarianFree,
  veganFree,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.veganFree: false,
          Filter.vegetarianFree: false,
        });

  void setFilters(Map<Filter, bool> chosenFilter) {
    state = chosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FilterNotifier, Map<Filter, bool>>((ref) {
  return FilterNotifier();
});

final filterMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((element) {
    if (activeFilters[Filter.glutenFree]! && element.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && element.isLactoseFree) {
      return false;
    }
    if (activeFilters[Filter.vegetarianFree]! && element.isVegetarian) {
      return false;
    }
    if (activeFilters[Filter.veganFree]! && element.isVegan) {
      return false;
    }
    return true;
  }).toList();
});
