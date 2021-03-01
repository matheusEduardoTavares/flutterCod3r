import 'package:flutter/material.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          child: ListView(
            children: <Widget> [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título'
                ),
                ///Podemos definir a [Action] de um
                ///input de forma que ao clicar para 
                ///confirmar após digitar o dado no 
                ///input, vai para o próximo input ao
                ///invés de apenas fechar o teclado, e
                ///para tal é só passar o [TextInputAction.next]
                ///para o atributo [textInputAction] do
                ///próprio [TextFormField]. Com isso,
                ///agora o botão de confirmar é trocado
                ///para avançar. Se for o último input
                ///da página, nesse caso então embora
                ///fique escrito avançar, ao clicar neste
                ///botão de avançar simplesmente o teclado
                ///fecha. Essa ação de ir para o próximo
                ///não acontece de forma automática, 
                ///para configurar isso precisaremos 
                ///controlar o [focusNode] dos inputs
                textInputAction: TextInputAction.next,
              )
            ]
          )
        ),
      )
    );
  }
}