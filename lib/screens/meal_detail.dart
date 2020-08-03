import 'package:flutter/material.dart';
import '../dummy_category.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal-details';

  final Function setFavorite;
  final Function isFavorite;
  MealDetail(this.setFavorite, this.isFavorite);

  Widget buildSectionTitle(BuildContext ctx, String title){
    return Container(
      margin: EdgeInsets.symmetric(vertical : 10),
      child: Text(
        title,
        style: Theme.of(ctx).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      height: 150,
      width: 300,
      child: child
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeList = ModalRoute.of(context).settings.arguments as Map<String, String>;
    final String idCategory = routeList['id'];
    final selectedMeal = DUMMY_MEALS.firstWhere((element) => element.id == idCategory);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(
                      selectedMeal.ingredients[index], 
                      style: TextStyle(color: Colors.white),
                    )
                  ),
                ),
              )
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (ctx, index) => 
                  Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('# ${(index + 1)}'),
                        ),
                        title: Text(
                          selectedMeal.steps[index],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Divider()
                    ],
                  )
              )
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setFavorite(idCategory),
        child: Icon(isFavorite(idCategory) ? Icons.favorite : Icons.favorite_border),
      ),
    );
  }
}