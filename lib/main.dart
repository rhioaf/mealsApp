import 'package:flutter/material.dart';
import 'package:mealsApp/dummy_category.dart';
import 'package:mealsApp/models/meal.dart';
import 'package:mealsApp/screens/categories.dart';
import 'package:mealsApp/screens/category_detail.dart';
import 'package:mealsApp/screens/meal_detail.dart';
import 'package:mealsApp/screens/settings.dart';
import 'package:mealsApp/screens/tab_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _settings = {
    'gluten' : false,
    'lactose' : false,
    'vegan' : false,
    'vegetarian' : false,
  };
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setSetting(Map<String, bool> data){
    setState(() {
      _settings = data;

      _availableMeals = DUMMY_MEALS.where((element) {
        if(_settings['gluten'] && !element.isGlutenFree){
          return false;
        }
        if(_settings['lactose'] && !element.isLactoseFree){
          return false;
        }
        if(_settings['vegetarian'] && !element.isVegetarian){
          return false;
        }
        if(_settings['vegan'] && !element.isVegan){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String id){
    final validateIndex = _favoriteMeals.indexWhere((element) => element.id == id);
    if(validateIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(validateIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id == id));
      });
    }
  }

  bool _isMealFavorite(String id){
    return _favoriteMeals.any((element) => element.id == id);
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.deepPurple,
        canvasColor: Colors.white54,
        fontFamily: 'Raleway',
        textTheme: ThemeData.dark().textTheme.copyWith(
          body1: TextStyle(
            color: Colors.black
          ),
          body2: TextStyle(
            color: Colors.black
          ),
          title: TextStyle(
            fontSize: 16,
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.bold
          )
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(_favoriteMeals),
        CategoryDetail.routeName : (ctx) => CategoryDetail(_availableMeals),
        MealDetail.routeName: (ctx) => MealDetail(_toggleFavorite, _isMealFavorite),
        Settings.routeName: (ctx) => Settings(_settings ,_setSetting),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen()
        );
      } ,
    );
  }
}