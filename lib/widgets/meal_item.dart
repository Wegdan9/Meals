

import 'package:flutter/material.dart';
import 'package:meals/screens/meal_detail_screen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  /** Widget for each element in the Meal List.
  Displaying passed [title, image, duration, complexity, affordability] of each meal.
  Navigate to MealDetailScreen using PUSHNAMED() using path and passing data [ID] of the meal pressed.
      */

  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;
  final Function? removeItem;

  MealItem({ required this.id, required this.title, required this.imageUrl, required this.duration, required this.complexity,
      required this.affordability,  this.removeItem, Key? key}) : super(key: key);

  String? get complexityText {
    switch (complexity) {
      case Complexity.Simple:
        return 'Simple';
        break;
      case Complexity.Challenging:
        return 'Challenging';
        break;
      case Complexity.Hard:
        return 'Hard';
        break;
      default: 'UNKNOWN';
    }
  }

  String? get affordabilityText {
    switch (affordability){
      case Affordability.Affordable:
        return 'Affordable';
        break;
      case Affordability.Pricey:
        return 'Pricey';
        break;
      case Affordability.Luxurious:
        return 'Luxurious';
        break;
      default: 'UNKNOWN';
    }
  }


  void selectMeal(BuildContext context) {
    Navigator.of(context).pushNamed(MealDetailScreen.routeName, arguments: id
    ).then((result) {
      removeItem!(result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        selectMeal(context);
      },
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          children: [
            Stack( // to show the image and the title on top of it
              children: [
                ClipRRect( // force the child into a certain form, which is border radius to match with the card shape
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                  child: Image.network(imageUrl, height: 250, width: double.infinity,fit: BoxFit.cover),
                ),
                Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                        //color: Colors.black54,
                        width: 300,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(title, style: const TextStyle(fontSize: 27,color: Colors.white),
                                    softWrap: true, overflow: TextOverflow.fade,
                        )
                    )
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                Row(children: [
                  const Icon(Icons.schedule),
                  SizedBox(width: 5),
                  Text('$duration')
                ],),
                Row(children: [
                  const Icon(Icons.work),
                  SizedBox(width: 5),
                  Text(complexityText!)
                ],
                ),
                Row(children: [
                  const Icon(Icons.money,),
                  SizedBox(width: 5),
                  Text(affordabilityText!)
                ],)
              ],
              ),
            )
          ],
        ),
      ),
    );
  }


}
