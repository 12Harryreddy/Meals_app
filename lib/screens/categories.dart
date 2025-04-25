import 'package:flutter/material.dart';
import 'package:meals/data/dummy_dart.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  CategoriesScreen({super.key, required this.filteredMeal});

  final List<Meal> filteredMeal;

  @override
  State<CategoriesScreen> createState() {
    return _CategoriesScreenState();
  }
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.filteredMeal.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return MealsScreen(
            title: category.title,
            meals: filteredMeals,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: availableCategories.map(
          (category) {
            return CategoryGridItem(
              category,
              onSelectCategory: () {
                _selectCategory(context, category);
              },
            );
          },
        ).toList(),
      ),
      builder: (ctx, child) => SlideTransition(
        position: Tween(
          begin: Offset(0, 0.3),
          end: Offset(0, 0),
        ).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOutCubicEmphasized),
        ),
        child: child,
      ),
    );
  }
}
