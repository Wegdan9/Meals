import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {

  static const String routeName ='/filters-screen';
  ///on clicking save data will be updated based on the filters
   Function saveFilters;
   Map<String, bool> currentFilters;
   FiltersScreen(this.currentFilters, this.saveFilters,{Key? key}) : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var  _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;

  @override
  initState(){ /// when state created which is happen when page is loaded we initialize values to match our filters
    _isGlutenFree = widget.currentFilters['gluten']!;
    _isLactoseFree = widget.currentFilters['lactose']!;
    _isVegan = widget.currentFilters['vegan']!;
    _isVegetarian = widget.currentFilters['vegetarian']!;
    super.initState();
  }

  Widget buildSwitchListTile(String title, String subTitle, bool currentValue, var updateValue){
    return SwitchListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        activeColor: Theme.of(context).colorScheme.primary,
        value: currentValue,
        onChanged: updateValue);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
        appBar: AppBar(title: Text('Your Filters'),
          actions: [
            IconButton(
                icon: Icon(Icons.save),
                onPressed:(){
                  final selectedFilters = {
                    'gluten': _isGlutenFree,
                    'lactose':_isLactoseFree,
                    'vegan': _isVegan,
                    'vegetarian':_isVegetarian,
                  };
                  widget.saveFilters(selectedFilters);
                  },
                  //print('its OK from filters screen'),
                 )
          ],
      ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              alignment: Alignment.center,
              child: Text('Adjust Your Meal!', style: Theme.of(context).textTheme.subtitle1,),
            ),
            Expanded(
              child: ListView(
                children: [
                  buildSwitchListTile('Gluten-Free', 'Only include Gluten-Free Meals.', _isGlutenFree, (newValue){
                    setState(() {
                      _isGlutenFree = newValue;
                    });
                  }),
                  const Divider(thickness: 2,indent: 20,endIndent: 20,),
                  buildSwitchListTile('Lactose-Free', 'Only include Lactose-Free Meals.', _isLactoseFree,  (newValue){
                    setState(() {
                      _isLactoseFree = newValue;
                    });
                  }),
                  const Divider(thickness: 2,indent: 20,endIndent: 20,),
                  buildSwitchListTile('Vegetarian', 'Only include Vegetarian Meals.', _isVegetarian, (newValue){
                    setState(() {
                      _isVegetarian = newValue;
                    });
                  }),
                  const Divider(thickness: 2,indent: 20,endIndent: 20,),
                  buildSwitchListTile('Vegan', 'Only include Vegan Meals.', _isVegan, (newValue){
                    setState(() {
                      _isVegan = newValue;
                    });
                  }),
                  const Divider(thickness: 2,indent: 20,endIndent: 20,),
                ],
              ),
            ),
          ],
        ),
    );}
}
