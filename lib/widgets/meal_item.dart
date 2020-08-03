import 'package:flutter/material.dart';
import 'package:mealsApp/models/meal.dart';
import 'package:mealsApp/screens/meal_detail.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String urlImage;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({
    @required this.id,
    @required this.title,
    @required this.urlImage,
    @required this.duration,
    @required this.complexity,
    @required this.affordability
  });

  String get complexityType {
    return 
      complexity == Complexity.Simple ? 'Simple' :
      complexity == Complexity.Medium ? 'Medium' :
      complexity == Complexity.Hard ? 'Hard' : 
      complexity == Complexity.Nightmare ? 'Nightmare' :
      'Unknown';
  }

  String get affordabilityType {
    return 
      affordability == Affordability.Affordable ? 'Affordable' :
      affordability == Affordability.Pricey ? 'Pricey' :
      affordability == Affordability.Luxurious ? 'Luxurious' : 
      'Unknown';
  }

  void _selected(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetail.routeName,
      arguments: {
        'id': id
      }
    ).then((value) {
      if(value != null){
        // removeItem(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selected(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        margin: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)
                  ),
                  child: Image.network(
                    urlImage,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 12,
                  right: 5,
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15
                    ),
                    color: Colors.black54,
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.schedule),
                      SizedBox(
                        width: 6,
                      ),
                      Text('$duration min'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.work),
                      SizedBox(
                        width: 6,
                      ),
                      Text(complexityType),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.monetization_on),
                      SizedBox(
                        width: 6,
                      ),
                      Text(affordabilityType),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}