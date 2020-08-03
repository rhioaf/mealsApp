import 'package:flutter/material.dart';
import 'package:mealsApp/models/meal.dart';
import 'package:mealsApp/widgets/meal_item.dart';

class FavoriteScreen extends StatelessWidget {

  final List<Meal> favoriteMeals;

  FavoriteScreen(this.favoriteMeals);

  @override
  Widget build(BuildContext context) {
    
    return favoriteMeals.isEmpty ? Center(
      child: Text('You have no favorites yet - start adding some'),
    )
    :
    ListView.builder(
      itemBuilder: (ctx, index) {
        return MealItem(
          id: favoriteMeals[index].id,
          title: favoriteMeals[index].title, 
          urlImage: favoriteMeals[index].imageUrl, 
          duration: favoriteMeals[index].duration, 
          complexity: favoriteMeals[index].complexity, 
          affordability: favoriteMeals[index].affordability,
        );
      },
      itemCount: favoriteMeals.length,
    );
  }
}