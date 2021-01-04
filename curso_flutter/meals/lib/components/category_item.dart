import 'package:flutter/material.dart';
import '../models/category.dart';
import '../screens/categories_meals_screen.dart';
class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem(this.category);

  void _selectCategory(BuildContext context){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CategoriesMealsScreen()
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    //Com o InkWell conseguimos ter um feedback
    //que o usuário clicou no child que está 
    //sendo um wrap do container, o que é mais
    //interessante nesse caso que o GestureDetector.
    //Como o child do InkWell tem bordas, temos que
    //definir as bordas no InkWell também para que
    //só seja clicável a área que estamos vendo,
    //que é do seu child.
    return InkWell(
      //Podemos colocar uma cor relacionada ao 
      //clique do efeito do feedback que é feito
      //do InkWell através da propriedade 
      //splashColor, e essa cor que definimos 
      //no splashColor acaba se misturando a cor 
      //do fundo do child e fica um efeito 
      //interessante.
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () => _selectCategory(context),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          //fazer uma borda arredondada:
          borderRadius: BorderRadius.circular(15),
          //Usaremos um gradiente linear para a cor 
          //passando nossa com com uma opacidade de 50% e
          //a cor em si. O LinearGradient possui outros 
          //parâmetros como o begin e end para definir onde
          //irá começar o gradiente e terminar, por exemplo
          //do superior esquerda para inferior direita, etc.
          //Dessa forma ele irá passar por todas as cores
          //da lista do colors que passaros para o Linear
          //Gradient, de cima para baixo fazendo assim o 
          //gradiente.
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          )
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.headline6
        ),
      ),
    );
  }
}