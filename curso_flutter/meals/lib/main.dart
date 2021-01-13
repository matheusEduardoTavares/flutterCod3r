import 'package:flutter/material.dart';
import 'screens/meal_detail_screen.dart';
import './screens/categories_screen.dart';
import 'screens/categories_meals_screen.dart';
import 'screens/tabs_screen.dart';
import 'screens/settings_screen.dart';
import 'utils/app_routes.dart';
 
void main() => runApp(MyApp());

//A lógica de estrutura de pastas neste APP é a seguinte:
//temos a pasta components onde estarão os widgets nossos
//e a pasta screens, que também serão componentes, mas 
//responsáveis por renderizar nossas páginas, já nos
//components serão apenas widgets de componentes mesmo,
//não serão páginas em si. Teremos também a pasta models
//para usar os modelos e a pasta data de onde pegaremos
//os dados dummy. Teremos também a pasta utils que
//terá alguns utilitários como o app_routes.dart,
//arquivo tal que conterá o nome das rotas.
 
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
      //Não precisamos mais passar o home quando
      //passamos uma rota default que é a rota
      //nomeada com /, para mudar esse padrão /,
      //podemos passar a propriedade initialRoute
      //para definir a rota inicial da aplicação.
      // initialRoute: ,
      routes: {
        //O / representa o home
        AppRoutes.HOME: (ctx) => TabsScreen(),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen(),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen(),
      },
      //RouteSettings são os metadados de uma determinada rota,
      onGenerateRoute: (settings) {
        //Aqui conseguimos definir rotas dinamicamente, por exempl
        //se foi colocado uma rota em um dado padrão vá para X,
        //por exemplo:
        if (settings.name == '/alguma-coisa') {
          //Aqui retornaríamos uma rota:
          return null;
        }
        else if (settings.name == '/outra-coisa'){
          return null;
        }
        else {
          //Se acabar não achando nenhuma rota nem no routes
          //e nem no if e else if, mostra uma página default
          //que no caso é a principal da aplicação, o 
          //CategoriesScreen().
          return MaterialPageRoute(
            builder: (_) {
              return CategoriesScreen();
            } 
          );
        }
        //Sempre é dado prioridade para o routes, ou seja, se a 
        //navegação encontrar uma rota e navegar corretamente não
        //irá entrar no método onGenerateRoute, mas caso não 
        //encontre uma rota no routes então será chamado o método
        //onGenerateRoute, e caso ainda no onGenerateRoute não
        //seja encontrado nenhuma rota, por último é chamado o 
        //método onUnknownRoute. Caso a função onGenerateRoute
        //não tenha sido criada, então já irá direto para 
        //onUnknownRoute
      },
      //Podemos fazer alguma lógica em cima do settings, para 
      //definir que rota será retornada.
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) {
            return CategoriesScreen();
          } 
        );
      }
    );
  }
}