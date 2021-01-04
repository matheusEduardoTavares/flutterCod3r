import 'package:flutter/material.dart';
import './screens/categories_screen.dart';
import 'screens/categories_meals_screen.dart';
 
void main() => runApp(MyApp());

//A lógica de estrutura de pastas neste APP é a seguinte:
//temos a pasta components onde estarão os widgets nossos
//e a pasta screens, que também serão componentes, mas 
//responsáveis por renderizar nossas páginas, já nos
//components serão apenas widgets de componentes mesmo,
//não serão páginas em si. Teremos também a pasta models
//para usar os modelos e a pasta data de onde pegaremos
//os dados dummy.
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed'
          )
        ),
        //O canvasColor é a cor de fundo da 
        //aplicação
        canvasColor: Color.fromRGBO(255, 254, 229, 1)
      ),
      home: CategoriesScreen(),
      routes: {
        //O / representa o home
        '/categories-meals': (ctx) => CategoriesMealsScreen(),
      }
    );
  }
}