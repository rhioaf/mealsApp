import 'package:flutter/material.dart';
import 'package:mealsApp/models/meal.dart';
import 'package:mealsApp/screens/categories.dart';
import 'package:mealsApp/screens/favorite.dart';
import 'package:mealsApp/widgets/drawer.dart';

class TabScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;

  TabScreen(this.favoriteMeals);


  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPage = 0;

  void _selectedTab(int index){
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  void initState() {
    _pages = [
      { 'page' : CategoriesScreen(),
        'title' : 'List Categories'
      },
      { 'page' : FavoriteScreen(widget.favoriteMeals),
        'title' : 'Your Favorites'
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedPage]['title']),
      ),
      drawer: DrawerApp(),
      body: _pages[_selectedPage]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedTab,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPage,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories') 
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text('Favorites') 
          )
        ],       
      ),
    );
  }
}