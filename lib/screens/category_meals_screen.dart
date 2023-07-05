import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';


class CategoryMealsScreen extends StatefulWidget {
  /** Widget for displaying MEALS on the screen.
   receiving data [ID, TITLE] of Category from CategoryItem.
   Storing data.
   Fetching, Displaying MEALS data [ID, TITLE, IMAGE, COMPLEXITY, AFFORDABILITY, DURATION] based on the matching of ID passed,
   passing it to MEALITEM which is a child responsible for each MealItem on the screen.
  */
  static const routeName = '/category-meals';
  final List<Meal> availableMeals;

/// reciveing meals based on filters not just all the meals.
  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String? categoryTitle;
  List<Meal>?  displayedMeals;


  @override
  void initState() {

    super.initState();
  }
  @override // instead of initState because of flutter declined the CONTEXT
  void didChangeDependencies() {
    final Map routeArgs = ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    //list with where method to return the true elements from this list to new list
    displayedMeals = widget.availableMeals.where((element) {
      return element.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }


  void _removeMeal(String mealId){
    setState(() {
    displayedMeals!.removeWhere((meal){
      return meal.id == mealId;
  });
    });
}

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(categoryTitle!, style: TextStyle(
            color: AppBarTheme.of(context).foregroundColor,
            fontFamily:'Raleway',
            fontSize: 22),
        ),

          centerTitle: AppBarTheme.of(context).centerTitle,
          shape: AppBarTheme.of(context).shape,elevation: AppBarTheme.of(context).elevation,

        ),
        body: ListView.builder(itemBuilder:
            (context, index) {
          return MealItem(
              id: displayedMeals![index].id,
              title: displayedMeals![index].title,
              imageUrl: displayedMeals![index].imageUrl,
              duration: displayedMeals![index].duration,
              complexity: displayedMeals![index].complexity,
              affordability: displayedMeals![index].affordability,
              removeItem: _removeMeal,);
        },
          itemCount:displayedMeals!.length,),
      ),
    );
  }


}


/**
 * here to call the constructor in Navigator.push() and send data in it, to receive it and manipulate
 * final String? passedItemId;
 * final String? passedItemTitle;
 * const CategoryMealsScreen({this.passedItemId, this.passedItemTitle ,Key? key}) : super(key: key);
 */