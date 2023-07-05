import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/main.dart';

class MealDetailScreen extends StatelessWidget {

  /** Widget for Displaying MealDetails on the screen.
  Receiving Data from MealItem which is Meal [ID].
  Storing data.
  Fetching, Displaying MealDetails data [IMAGE, INGREDIANTS, STEPS] based on matching Id passed
  */

  static const routeName ='/mealDetail';
  final Function toggleFavorite;
  final Function isFavorite;

  const MealDetailScreen(this.toggleFavorite,this.isFavorite,{Key? key}) : super(key: key);

  Widget sectionTitle(BuildContext context, String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(title, style: Theme
          .of(context)
          .textTheme
          .subtitle1,),
    );
  }

  Widget containerDecoration(BuildContext context, Widget child) {
    return Stack(
      children:[
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)
          ),
          margin: EdgeInsets.all(12),
          padding: EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.35,
          width: double.infinity,
          child: child),
        Positioned(
          bottom: MediaQuery.of(context).size.width * 0.04,
          left: MediaQuery.of(context).size.width * 0.47,
          right: MediaQuery.of(context).size.width * 0.47,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(100)),

            child: Icon(Icons.arrow_drop_down_sharp),
          ),
        )
    ]
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments;
    final selectedMeal = DUMMY_MEALS.firstWhere((element) {
      return element.id == mealId;
      //return element.id.contains(mealId.toString());
    });

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(title: Text(selectedMeal.title, style: TextStyle(
              color: AppBarTheme.of(context).foregroundColor,
              fontFamily:'Raleway',
              fontSize: 22),
          ),

            centerTitle: AppBarTheme.of(context).centerTitle,
            shape: AppBarTheme.of(context).shape,elevation: AppBarTheme.of(context).elevation,

          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20)
                ),
                height: MediaQuery.of(context).size.height * 0.4,
                width: double.infinity,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover,)),
              ),
              sectionTitle(context, 'Ingredients'),
                containerDecoration(context,
                   ListView.builder(itemBuilder: (context, index){
                    return Card(
                      color: Theme.of(context).colorScheme.secondary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(selectedMeal.ingredients[index], style: Theme.of(context).textTheme.subtitle1,),
                      ),
                    );
                  },
                    itemCount: selectedMeal.ingredients.length,),
                ),
                sectionTitle(context, 'Steps'),
                containerDecoration(context,
                  ListView.builder(itemBuilder: (context, index){
                    return Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondary,
                              child: Text('#' '${index+1}')
                          ),
                          title: Text(selectedMeal.steps[index], ),
                        ),
                        Divider(thickness: 2),
                      ],
                    );
                  },
                    itemCount: selectedMeal.steps.length,)
                )

            ],),
          ),
        floatingActionButton: FloatingActionButton(
            child: Icon(isFavorite(mealId) ? Icons.star : Icons.star_border),
            onPressed: ()=>toggleFavorite(mealId),
                //Navigator.of(context).pop(mealId);



        ),
      ),
    );
  }
}
