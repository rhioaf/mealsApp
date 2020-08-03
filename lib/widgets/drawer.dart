import 'package:flutter/material.dart';
import 'package:mealsApp/screens/settings.dart';

class DrawerApp extends StatelessWidget {
  Widget buildDrawerItem(String title, IconData icon, Function onClick){
    return ListTile(
      leading: Icon(
        icon, 
        size: 26,
      ),
      title: Text(
        title, 
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),
      ),
      onTap: onClick,
    );
  }



  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(15),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
                color: Theme.of(context).primaryColor
              ),
            ),
          ),
          SizedBox(height: 20),
          buildDrawerItem(
            'Meals', 
            Icons.restaurant_menu, 
            (){
              Navigator.of(context).pushReplacementNamed('/');
            }
          ),
          buildDrawerItem(
            'Settings', 
            Icons.settings_applications, 
            (){
              Navigator.of(context).pushReplacementNamed(Settings.routeName);
            }
          ),
        ],
      ),
    );
  }
}