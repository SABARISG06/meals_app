import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/Providers/filters_provider.dart';

import 'package:meals/widgets/switch_tile.dart';

// enum Filter {
//   glutenFree,
//   lactoseFree,
//   vegetarianFree,
//   veganFree,
// }

class FilterScreen extends ConsumerWidget {
  const FilterScreen({
    super.key,
  });
  // final Map<Filter, bool> currentFilters;

//   @override
//   ConsumerState<FilterScreen> createState() {
//     return _FilterScreenState();
//   }
// }

// class _FilterScreenState extends ConsumerState<FilterScreen> {
//   var _isGlutenFreeState = false;
//   var _isLactoseFreeState = false;
//   var _isVegetarianFreeState = false;
//   var _isVeganFreeState = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     final activeFilter = ref.read(filtersProvider);
//     _isGlutenFreeState = activeFilter[Filter.glutenFree]!;
//     _isLactoseFreeState = activeFilter[Filter.lactoseFree]!;
//     _isVegetarianFreeState = activeFilter[Filter.vegetarianFree]!;
//     _isVeganFreeState = activeFilter[Filter.veganFree]!;
//   }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentActiveFilter = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Column(
        children: [
          SwitchTile(
              value: currentActiveFilter[Filter.glutenFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.glutenFree, isChecked);
              },
              title: 'Gluten-Free',
              subTitle: 'Only include glute free meals'),
          SwitchTile(
              value: currentActiveFilter[Filter.lactoseFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.lactoseFree, isChecked);
              },
              title: 'Lactose-Free',
              subTitle: 'Only include Lactose free meals'),
          SwitchTile(
              value: currentActiveFilter[Filter.vegetarianFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vegetarianFree, isChecked);
              },
              title: 'Vegetarian',
              subTitle: 'Only include Vegetarian free meals'),
          SwitchTile(
              value: currentActiveFilter[Filter.veganFree]!,
              onChanged: (isChecked) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.veganFree, isChecked);
              },
              title: 'Vegan',
              subTitle: 'Only include Vegan free meals'),
        ],
      ),
    );
  }
}
