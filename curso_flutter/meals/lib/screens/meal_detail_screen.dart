import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../utils/app_routes.dart';

class MealDetailScreen extends StatelessWidget {
  final void Function(Meal) onToggleFavorite;
  final bool Function(Meal) isFavorite;

  const MealDetailScreen(this.onToggleFavorite, this.isFavorite);

  Widget _createSectionTitle(BuildContext context, String title, {EdgeInsetsGeometry margin, Widget child, TextStyle style}){
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 10),
      child: child ?? Text(
        title,
        style: style ?? Theme.of(context).textTheme.headline6,
      ),
    );
  }

  Widget _createSectionContainer(Widget child, {double width, double height, EdgeInsetsGeometry margin,
    EdgeInsets padding, BoxDecoration decoration, Color color, BoxBorder border, BorderRadiusGeometry borderRadius}){
    return Container(
      width: width ?? 330,
      height: height ?? 250,
      padding: padding ?? const EdgeInsets.all(10),
      margin: margin ?? const EdgeInsets.all(10),
      decoration: decoration ?? BoxDecoration(
        color: color ?? Colors.white,
        border: border ?? Border.all(color: Colors.grey),
        borderRadius: borderRadius ?? BorderRadius.circular(10)
      ),
      child: child
    );
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final meal = arguments['meal'] as Meal;
    final hasReplacementScreen = arguments['hasReplacementScreen'];

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        leading: (hasReplacementScreen ?? false) ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
        ) : null,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget> [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              )
            ),
            _createSectionTitle(context, 'Ingredientes'),
            _createSectionContainer(ListView.builder(
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
            )),
            _createSectionTitle(context, 'Passos'),
            _createSectionContainer(
              ListView.builder(
                itemCount: meal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('${index + 1}')
                        ),
                        title: Text(meal.steps[index]),
                      ),
                      Divider()
                    ],
                  );
                }
              )
            )
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFavorite(meal) ? Icons.star : Icons.star_border),
        onPressed: () {
          onToggleFavorite(meal);
        }
      ),
    );
  }
}