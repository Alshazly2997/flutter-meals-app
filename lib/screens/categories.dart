import 'package:app004/data/dummy_data.dart';
import 'package:app004/screens/meals.dart';
import 'package:app004/widgets/category_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:app004/models/category.dart';
import 'package:app004/models/meal.dart';

class CategoriesScreen extends StatefulWidget{
  const CategoriesScreen({
    super.key,
    required this.availablemeals
  });

  final List<Meal> availablemeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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

  void _selecteCategory(BuildContext context, Category category) {
    final filteredMeals= widget.availablemeals
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
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0),
          ).animate(
            CurvedAnimation(
              parent: _animationController, 
              curve: Curves.linear
              )
            ),
        child: child,
      ),
    ); 
  } 
}