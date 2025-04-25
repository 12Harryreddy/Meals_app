import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_detail.dart';
import 'package:meals/widgets/meals_item.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key,  this.title, required this.meals,});

  final List<Meal> meals;
  final String? title;


  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) {
          return MealsDetailScreen(
            meal: meal,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = ListView.builder(
        itemCount: meals.length,
        itemBuilder: (ctx, index) {
          return MealsItem(
            meal: meals[index],
            onSelectMeal: (meal) {
              _selectMeal(context, meal);
            },
          );
        });
    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Uh huh! No meals available!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Try finding different category!',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onSurface),
            ),
          ],
        ),
      );
    }
    if(title == null)  {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
