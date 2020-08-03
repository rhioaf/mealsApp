import 'package:flutter/material.dart';
import 'package:mealsApp/models/meal.dart';
import 'package:mealsApp/widgets/meal_item.dart';

class CategoryDetail extends StatefulWidget {
  static const routeName = '/category-detail';

  final List<Meal> availableMeals;
  CategoryDetail(this.availableMeals);

  @override
  _CategoryDetailState createState() => _CategoryDetailState();
}

class _CategoryDetailState extends State<CategoryDetail> {

  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
      final routeList = ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeList['title'];
      final categoryId = routeList['id'];
      displayedMeals = widget.availableMeals.where((element) {
        return element.categoryId.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  void _removeItem(String idMeal){
    setState(() {
      displayedMeals.removeWhere((element) => element.id == idMeal);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title, 
            urlImage: displayedMeals[index].imageUrl, 
            duration: displayedMeals[index].duration, 
            complexity: displayedMeals[index].complexity, 
            affordability: displayedMeals[index].affordability,
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}