import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../components/meal_item.dart';

class FavoriteScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const FavoriteScreen(this.favoriteMeals);

  @override 
  Widget build(BuildContext context){
    if (favoriteMeals.isEmpty){
      return Center(
        child: Text('Nenhuma refeição foi marcada como favorita'),
      );
    }
    else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (context, index) => MealItem(
          favoriteMeals[index]
        )
      );
    }

    //No caso das tela favorita, diferente das outras
    //3 telas que temos no momento, ela não será 
    //construída usando um Scaffold, pois o componente
    //scaffold estará dentro do componente que criaremos
    //agora. Criaremos um componente que irá mostrar e
    //um componente que irá controlar as abas, a 
    //transição entre um componente e outro.
    
  }
}