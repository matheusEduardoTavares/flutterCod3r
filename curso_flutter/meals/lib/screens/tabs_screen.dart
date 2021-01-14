import 'package:flutter/material.dart';
import 'categories_screen.dart';
import 'favorite_screen.dart';
import '../components/main_drawer.dart';
import '../models/meal.dart';

typedef UpdateTabIndex = void Function(int);
class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeal;
  final int initialIndex;
  final UpdateTabIndex updateTabIndex;

  const TabsScreen(this.favoriteMeal, {@required this.initialIndex, @required this.updateTabIndex});

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _screens;

  @override 
  void initState(){
    super.initState();
    
    _screens = [
      { 'title': 'Lista de Categorias', 'screen': CategoriesScreen() },
      { 'title': 'Meus Favoritos', 'screen': FavoriteScreen(widget.favoriteMeal) }
    ];

  }

  void _selectScreen(int index){
    setState(() {
      widget.updateTabIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[widget.initialIndex]['title']),
        centerTitle: true,
      ),
      body: _screens[widget.initialIndex]['screen'],
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: widget.initialIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favoritos'
          )
        ]
      )
    );
  }
}