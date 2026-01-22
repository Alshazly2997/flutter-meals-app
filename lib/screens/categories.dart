import 'package:app004/data/dummy_data.dart';
import 'package:app004/screens/meals.dart';
import 'package:app004/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:app004/models/category.dart';
import 'package:app004/models/meal.dart';

class CategoriesScreen extends StatelessWidget{
  const CategoriesScreen({
    super.key,
    required this.availablemeals
  });

  final List<Meal> availablemeals;


  void _selecteCategory(BuildContext context, Category category) {
    final filteredMeals= availablemeals
    .where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealesScreen(
          title: category.title, 
          meals: filteredMeals,
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3/2.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category, 
              onSelectCategory: () {
                _selecteCategory(context, category);
              }
            ),
        ],
    );
  } 
}