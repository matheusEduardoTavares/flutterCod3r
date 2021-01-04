import 'package:flutter/material.dart';
import '../components/category_item.dart';
import '../data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    //No caso da ListView um componente fica abaixo do outro
    //mas no caso de uma GridView os componentes ficam em
    //grade, conseguimos os posicionar da maneira que 
    //queremos.
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Vamos Cozinhar?'),
      ),
      body: GridView(
        padding: const EdgeInsets.all(25),
        //Sliver no contexto do flutter é uma área que tem 
        //scroll, grid delegate é uma forma de delegar como
        //a grid será delegada, que no caso é extendendo do 
        //ponto de vista do cross axis (eixo X)
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //Cada elemento tem uma extensão de no máximo 200 
          //pixels, se colocarmos então uma tela com 800 de
          //largura terá 4 elementos na mesma linha e assim
          //sucessivamente
          maxCrossAxisExtent: 200,
          //Proporção de cada elemento dentro do gridView, 
          //ou seja, colocando 3 / 2 significa que teremos
          //2 itens na horizontal.
          childAspectRatio: 3 / 2,
          //Espaçamento no eixo X entre elementos de 20
          crossAxisSpacing: 20,
          //Espaçamento no eixo Y entre elementos de 20
          mainAxisSpacing: 20
        ),
        children: DUMMY_CATEGORIES.map((category) => CategoryItem(
            category,
          )
        ).toList(),
      ),
    );
  }
}