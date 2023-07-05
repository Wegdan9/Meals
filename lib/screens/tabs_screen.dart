import 'package:flutter/material.dart';
import 'package:meals/screens/categories_screen.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';
import 'favorites_screen.dart';

class TabsScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;
  const TabsScreen(this.favoriteMeals,{Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}


class _TabsScreenState extends State<TabsScreen> {

   List<Map<String, dynamic>>? _pages ;

  @override
  void initState(){
    _pages =[
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavoritesScreen(widget.favoriteMeals), 'title': 'Favorites'}
    ];
  }
  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: MainDrawer(),
          appBar: AppBar(
        title: Text(
          _pages![_selectedPageIndex]['title'],
          style: TextStyle(
              color: AppBarTheme.of(context).foregroundColor,
              fontFamily: 'Raleway',
              fontSize: 22),
        ),
        centerTitle: AppBarTheme.of(context).centerTitle,
        shape: AppBarTheme.of(context).shape,
        elevation: AppBarTheme.of(context).elevation,
      ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Theme.of(context).colorScheme.secondary,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedPageIndex,
          type: BottomNavigationBarType.shifting,
          items:  [
            BottomNavigationBarItem(backgroundColor: Theme.of(context).colorScheme.primary, icon: Icon(Icons.category), label: 'Categories'),
            BottomNavigationBarItem(backgroundColor: Theme.of(context).colorScheme.primary, icon: Icon(Icons.star), label: 'Favorites')
          ],
        ),
        body: _pages![_selectedPageIndex]['page'],
      ),
    );
  }


}
/**
 * DefaultTabController(
    initialIndex: 0,
    length: 2,
    child: SafeArea(
    child: Scaffold(
    appBar: AppBar(
    title: Text('DeliMeal', style: TextStyle(
    color: AppBarTheme.of(context).foregroundColor,
    fontFamily:'Raleway',
    fontSize: 22),
    ),
    centerTitle: AppBarTheme.of(context).centerTitle,
    shape: AppBarTheme.of(context).shape,
    elevation: AppBarTheme.of(context).elevation,
    bottom: const TabBar(
    indicatorColor: Colors.white,
    tabs: [
    Tab(icon: Icon(Icons.category),
    text: 'Categories',),
    Tab(icon: Icon(Icons.star),
    text: 'Favorites',)
    ]),
    ),
    body: const TabBarView(children: [
    CategoriesScreen(),
    FavoritesScreen()
    ]),

    ),
    ));
 * */