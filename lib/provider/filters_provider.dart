
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/provider/meals_provider.dart';
import 'package:meals/screens/filters.dart';


enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifer extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifer() : super({
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
    Filter.glutenFree: false,
  });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state, filter: isActive
    };
  }
}


final filtersProvider = StateNotifierProvider<FiltersNotifer, Map<Filter,bool>>(
    (ref) => FiltersNotifer(),
);

final filteredMealProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final selectedFilters = ref.watch(filtersProvider);
  return meals.where(
        (meal) {
      if (!meal.isVegetarian && selectedFilters[Filter.vegetarian]!) {
        return false;
      }
      if (!meal.isVegan && selectedFilters[Filter.vegan]!) {
        return false;
      }

      if (!meal.isLactoseFree && selectedFilters[Filter.lactoseFree]!) {
        return false;
      }

      if (!meal.isGlutenFree && selectedFilters[Filter.glutenFree]!) {
        return false;
      }
      return true;
    },
  ).toList();
});