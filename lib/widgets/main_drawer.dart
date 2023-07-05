import 'package:flutter/material.dart';
import 'package:meals/screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);
  
  Widget buildListTile(String title, IconData icon, VoidCallback tabHandler){
    return ListTile(
      leading: Icon(icon, size: 24,),
      title: Text(title, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, fontFamily: 'RobotoCondesed'),),
      onTap: tabHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Theme.of(context).colorScheme.secondary,
            padding: EdgeInsets.all(5),
            height: 120,
            alignment: Alignment.centerLeft,
            child: Text('Cooking Up!', style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 30, fontWeight: FontWeight.w900),),
          ),
          SizedBox(height: 15,),
          buildListTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Filters', Icons.settings,(){
            Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
          }),
        ],
      ),
    );
  }
}
