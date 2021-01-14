import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../utils/app_routes.dart';

/*
No momento temos o seguinte problema na aplicação:
Quando favoritamos uma comida, vamos na tela de 
favorito e desfavoritamos a comida, se clicarmos
para voltar na tela anterior a comida continuará lá,
a atualização do toggle se é favorito ou não realmente
aconteceu, tanto que se trocarmos de aba e voltarmos
veremos que a atualização ocorreu. Porém não é atualizado
pois quando damos um pop, a tela que estava na pilha é
deixada em forma de cache, e quando ela volta a 
aparecer, não foi atualizada. Quando trabalharmos com
gerência de estado esse problema não irá acontecer.
Esse problema tem haver com o gerenciamento de estado
da aplicação, não tem haver com a parte de rotas.
Uma forma de corrigir temporariamente é ao invés de
dar um pushNamed para a tela, dar um pushReplacementNamed
e para sair da tela também dar um pushReplacementNamed.
Não foi abordado mas resolvi o problema fazendo
o que fora citado e passando o índice do tab para o main.dart
*/

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
                //Ajustar a imagem da melhor forma possível
                //usamos o BoxFit.cover
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
          // Navigator.of(context).pop(meal.title);
          onToggleFavorite(meal);
        }
      ),
    );
  }
}