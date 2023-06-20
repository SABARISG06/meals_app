import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/model/category.dart';
import 'package:meals/model/meals.dart';
import 'package:meals/screens/meal.dart';
import 'package:meals/widgets/categories_grid_items.dart';

class CategoriesUI extends StatefulWidget {
  const CategoriesUI(
      {super.key,
      // required this.onToggleFavorites,
      required this.availableMeal});

  // final void Function(Meal meal) onToggleFavorites;
  final List<Meal> availableMeal;

  @override
  State<CategoriesUI> createState() => _CategoriesUIState();
}

class _CategoriesUIState extends State<CategoriesUI>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 1,
      lowerBound: 0,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  void _navigatorScreen(BuildContext context, Category category) {
    final filteredList = widget.availableMeal.where((element) {
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
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}

// Padding(
//         padding: EdgeInsets.only(top: 100 - _animationController.value * 100),
//         child: child,
//       ),