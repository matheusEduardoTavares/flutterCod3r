import 'package:flutter/material.dart';
import '../models/category.dart';
import '../components/meal_item.dart';
import '../models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  final List<Meal> meals;

  const CategoriesMealsScreen(this.meals);

  @override
  Widget build(BuildContext context) {
    //Obtemos os arguments passados na 
    //hora de usar o Navigator com o 
    //ModalRoute.of .
    final category = ModalRoute.of(context).settings.arguments as Category;

    final categoryMeals = meals.where((meal) => meal.categories.contains(category.id)).toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          category.title,
        ),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (context, index) => MealItem(categoryMeals[index], hasReplacementScreen: false,)
      )
    );
  }
}