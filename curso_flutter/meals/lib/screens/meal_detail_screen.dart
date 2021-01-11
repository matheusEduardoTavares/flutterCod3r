import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final meal = ModalRoute.of(context).settings.arguments as Meal;
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title)
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                //Ajustar a imagem da melhor forma possível
                //usamos o BoxFit.cover
                fit: BoxFit.cover,
              )
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10
              ),
              child: Text(
                'Ingredientes',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Container(
              width: 300,
              height: 250,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10)
              ),
              child: ListView.builder(
                itemCount: meal.ingredients.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10
                      ),
                      child: Text(meal.ingredients[index]),
                    ),
                    color: Theme.of(context).accentColor,
                  );
                }
              )
            )
          ]
        ),
      )
    );
  }
}