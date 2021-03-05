import 'package:flutter/material.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

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
                onFieldSubmitted: (_) {
                  ///Para ir para o próximo input do 
                  ///Focus:
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              ///Hoje em dia já funciona ir para o próximo
              ///item mesmo sem usar o [FocusNode]
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Preço',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                focusNode: _priceFocusNode,
                onFieldSubmitted: (_) {
                  FocusScope.of(context)
                    .requestFocus(_descriptionFocusNode);
                }
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descrição'
                ),
                maxLines: 3,
                ///No caso do IOs, o [TextInputType.multiline]
                ///não terá o mesmo comportamento do android
                keyboardType: TextInputType.multiline,
                ///Ao tirar o [TextInputAction.next], agora
                ///ao clicar onde ficava o ícone de done ou
                ///de ir para o próximo, será pulado uma linha
                ///pois criamos um [TextFormField] com 3 linhas,
                ///e como sua ação não é de ir para um próximo
                ///[TextFormField], então apenas são pulados as 
                ///linhas desse campo já que é um campo marcado
                ///com [TextInputType.multiline]
                // textInputAction: TextInputAction.next,
                focusNode: _descriptionFocusNode,
              ),
            ],
          )
        ),
      ),
    );
  }

  @override 
  void dispose() {
    _priceFocusNode?.dispose();
    _descriptionFocusNode?.dispose();

    super.dispose();
  }
}