import 'package:flutter/material.dart';
import '../screens/category_meals_screen.dart';

class CategoryItem extends StatelessWidget {

  /** Widget for each element in the Category list ,
   Displaying passed [TITLE, COLOR] of the category
   Navigates to CategoryMealsScreen using PUSHNAMED() with path and passing data which is [ID, TITLE] of the category pressed
   */
  final String itemId;
  final String itemTitle;
  final Color itemColor;

  CategoryItem(this.itemId, this.itemTitle, this.itemColor, {Key? key}) : super(key: key);

  void selectedCategoryNavigator(BuildContext context){
    Navigator.of(context).pushNamed(CategoryMealsScreen.routeName,arguments: {
      'id':itemId,
      'title':itemTitle
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(//2) i built it for tap and navigate
      splashColor: Theme.of(context).colorScheme.primary, // on long press color
      borderRadius: BorderRadius.circular(15),
      onTap: (){
        selectedCategoryNavigator(context);
      },
      child: Container(// 1) i built a container first
        padding: const EdgeInsets.all(20),
        child: Text(itemTitle,style: Theme.of(context).textTheme.subtitle1,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(colors: [
              itemColor,
              itemColor.withOpacity(0.7),
            ], begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
        ),
      ),
    );
  }
}
