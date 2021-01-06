import 'package:flutter/material.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;

  const MealItem(this.meal);

  void _selectMeal() {}

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _selectMeal,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 4,
        margin: const EdgeInsets.all(10),
        child: Column(
          children: <Widget> [
            //Para colocarmos um widget por cima de outro
            //usamos o Stack
            Stack(
              children: <Widget> [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)
                  ),
                  //Só colocar o Image.network sem um wrap 
                  //em volta dele gera um problema em que estamos
                  //dentro de um card que tem as bordas circulares
                  //e estamos colocando uma imagem quadrada para
                  //ficar em cima de um componente que tem bordas
                  //circulas. Isso vai gerar que simplesmente 
                  //acabará perdendo as bordas circulares, então
                  //para arrumar isso, fazemos um wrap em 
                  //Image.network com um ClipRRect, que é um 
                  //widget que faz o trabalho de definir as bordas
                  //para um determinado componente, garantindo que
                  //a imagem ficará contida nessas bordas. Mas
                  //no caso queremos que tenha apenas as bordas
                  //circulas em cima, pois a imagem está dentro do
                  //card, e abaixo da imagem haverá textos, então
                  //essa parte dos textos no fim deles em baixo 
                  //é onde estará as bordas circulares do card, 
                  //já em cima a imagem é o primeiro componente
                  //visual dentro do card, logo só terá as bordas
                  //arredondadas em cima.
                  child: Image.network(
                    meal.imageUrl,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              ]
            )
          ]
        )
      ),
    );
  }
}