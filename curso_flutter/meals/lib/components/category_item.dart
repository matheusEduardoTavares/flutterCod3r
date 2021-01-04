import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem(this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}