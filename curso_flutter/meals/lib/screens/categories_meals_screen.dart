import 'package:flutter/material.dart';

class CategoriesMealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Receitas',
        ),
      ),
      body: Center(
        child: Text(
          'Receitas por Categoria',
        ),
      )
    );
  }
}