import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/main.dart';
import '../widgets/category_item.dart';

class CategoriesScreen extends StatelessWidget {

  /** Widget for displaying CATEGORIES on screen.
   Fetching, Displaying category data which is Category [id, title, color] and
   passing it to CATEGORYITEM which is a child responsible for each CategoryItem on the screen.
   */
  const CategoriesScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context){
    return GridView(//1) built it to show the data from source
          padding: const EdgeInsets.all(8),
          children: [
            ...DUMMY_CATEGORIES.map((element) =>
                CategoryItem(element.id!, element.title!, element.color!)),
          ],
          /** slivers are scrollable area on screens
              SliverGridDelegateWithMaxCrossAxisExtent() class which allow us to define max width for each grid item,
              so it automatically create as many columns as we can fit items with that provided width next to each other
              maxCrossAxisExtent: 200 depends on device size if size is 300 px width so it will have one item.
              childAspectRation: 3/2 defines how items should be sized regarding their height and width relation.
              crossAxisSpacing, mainAxisSpacing defines how much distance between columns and rows in that grid.

           */
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ));
  }
}


/** GridView.builder(gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 200,
    childAspectRatio: 3/2,
    crossAxisSpacing: 20,
    mainAxisSpacing: 20,
    ), itemBuilder: (context, index){
    return CategoryItem(DUMMY_CATEGORIES[index].id!, DUMMY_CATEGORIES[index].title!, DUMMY_CATEGORIES[index].color!);
    }, itemCount: DUMMY_CATEGORIES.length,)*/