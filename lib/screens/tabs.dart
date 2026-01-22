import 'package:app004/screens/categories.dart';
import 'package:app004/screens/fiters.dart';
import 'package:app004/screens/meals.dart';
import 'package:app004/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app004/providers/favorites_provider.dart';
import 'package:app004/providers/filters_provider.dart';

const  kInitialFilter = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false
  };

class TabsScreen extends ConsumerStatefulWidget{
  const TabsScreen({
    super.key
  });

  @override
  ConsumerState<TabsScreen> createState() {
    return TabsScreenState();
  }

}


class TabsScreenState extends ConsumerState<TabsScreen>{
  int _selectePageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectePageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      await Navigator.of(context).push<Map<Filter,bool>>(MaterialPageRoute(builder: (ctx) => const FiltersScreen()));
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final availablemeals = ref.watch(filterMealsProvider);

    Widget activePage =  CategoriesScreen(availablemeals: availablemeals,);
    var activePageTitle = 'Categories';

    if (_selectePageIndex == 1) {
      final favoriteMeal = ref.watch(favoriteMealsProvider);
      activePage = MealesScreen(meals: favoriteMeal);
      activePageTitle = 'Your Favorties';
    }

    return Scaffold(
      backgroundColor: ColorScheme.of(context).surface,
      appBar: AppBar(
        title: Text(activePageTitle),
        centerTitle: true,
        backgroundColor: ColorScheme.of(context).surface,
      ),
      drawer: MainDrawer(onSelectScreen: _setScreen,),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorScheme.of(context).onSecondary,
        onTap: _selectPage,
        currentIndex: _selectePageIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),

        ],
      ),
    );
  }
}