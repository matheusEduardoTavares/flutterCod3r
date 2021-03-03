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
          key: ValueKey(''),
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título',
                ),
                ///Atributo que serve para definir qual
                ///será a ação do input. Ao usar o 
                ///[TextInputAction.next], ao invés do
                ///botão confirmar irá aparecer um botão
                ///escrito avançar, e assim, se houverem 
                ///mais [TextFormField] e for programado
                ///para ir para um próximo - é o dev quem
                ///programa isso através dos [FocusNode],
                ///então irá para o próximo input de acordo
                ///com o que foi definido no [FocusNode]. Se
                ///for o último input, apenas fecha o teclado.
                textInputAction: TextInputAction.next,
              )
            ],
          )
        ),
      ),
    );
  }
}