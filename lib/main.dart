import 'package:flutter/material.dart';
import './dummy_data.dart';
import './models/meal.dart';
import './pages/filters_page.dart';
import './pages/tabs_page.dart';
import './pages/meal_detail_page.dart';
import './pages/category_meals_page.dart';
// import './pages/categories_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] == true && !meal.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String id) {
    // checks if id is in array and return the index
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == id);
    if (existingIndex >= 0)
      setState(() => _favoriteMeals.removeAt(existingIndex));
    else
      setState(() => _favoriteMeals
          .add(DUMMY_MEALS.firstWhere((element) => element.id == id)));
  }

  bool _isMealFavorite(String id) {
    return _favoriteMeals.any((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recette de cuisine',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.teal,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      routes: {
        '/': (ctx) => TabsPage(_favoriteMeals),
        CategoryMealsPage.routeName: (ctx) =>
            CategoryMealsPage(_availableMeals),
        MealDetailPage.routeName: (ctx) =>
            MealDetailPage(_toggleFavorite, _isMealFavorite),
        FiltersPage.routeName: (ctx) => FiltersPage(_setFilters, _filters),
      },
    );
  }
}
