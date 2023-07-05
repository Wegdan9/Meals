import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import './screens/filters_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/categories_screen.dart';
import './screens/category_meals_screen.dart';
import 'models/meal.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  /// default values for filters as we start the app
  Map <String, bool> _filters = {
  'gluten': false,
  'lactose':false,
  'vegan': false,
  'vegetarian':false,
};

/// when app starts available meals is just a pointer to meals we got here,
///  we passed it to categoryMeals to be sure that we using the available meals according to the filters
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals =[];

  /// method should be called from filterScreen when user click a button
  void _setFilters(Map<String, bool> filterData){

  setState(() { /// to update the filters by the new filter data from user
    _filters = filterData;
    /// here we will filter the data
    _availableMeals = DUMMY_MEALS.where((meal) {
      /// if gluten value is True from user AND check each meal value of gluten in the source is False
      if(_filters['gluten']! && !meal.isGlutenFree){
        return false;
      }
      if(_filters['lactose']! && !meal.isLactoseFree){
        return false;
      }
      if(_filters['vegan']! && !meal.isVegan){
        return false;
      }
      if(_filters['vegetarian']! && !meal.isVegetarian){
        return false;
      }
      return true;
    }).toList();
  });
  }
  void _toggleFavorite(String mealId){
    /// indexWhere() returns the index of the existing item in the list otherwise returns 0.
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if(existingIndex >= 0){
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    }else{
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id ==mealId));
      });
    }
  }
bool _isMealFavorite(String id){
    ///any() any element in the list has the same ID
    return _favoriteMeals.any((meal) => meal.id == id);
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DeliMeals',
      theme: ThemeData( //THEMING APP
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(secondary: Colors.amber),//primary color, secondary color
        fontFamily: 'Raleway', // font family of the app
        canvasColor: const Color.fromRGBO(255, 254, 229, 1), // bg color
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            subtitle1: const TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed',fontWeight: FontWeight.bold)
        ),
        appBarTheme: const AppBarTheme(
            elevation: 10,
            foregroundColor: Colors.white,
            centerTitle: true,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20),
            )
            )
        ),

      ),
      //home: CategoriesScreen(),
      initialRoute: '/',
      routes: {
        '/':(context) => TabsScreen(_favoriteMeals),
        CategoryMealsScreen.routeName :(context) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName :(context) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName:(context) => FiltersScreen(_filters,_setFilters),
      },

      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (_){
          return CategoriesScreen();
        });
      }, //reached when flutter failed to build a screen with all other routes before ERROR

    );
  }
}




