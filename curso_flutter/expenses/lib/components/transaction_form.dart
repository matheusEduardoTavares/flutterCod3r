import 'package:flutter/material.dart';

typedef AddTransaction = void Function(String, double);

class TransactionForm extends StatelessWidget {
  final AddTransaction onSubmit;

  TransactionForm({
    @required this.onSubmit
  });

  final titleController = TextEditingController();
  final valueController = TextEditingController();

  void _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0){
      return;
    }

    onSubmit(title, value);
  }

  @override 
  Widget build(BuildContext context){
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget> [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Título'
              ),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              //Usando um controller não precisa de um onChanged
              //e ir sobrescrevendo o valor da variável referente 
              //ao text field a partir do valor atual do onChanged,
              //uma vez que muda automaticamente dentro do controller
              //o estado do controller vai sendo alterado a partir
              //do momento que vamos digitando as informações
              controller: valueController,
              decoration: InputDecoration(
                labelText: 'Valor (R\$)'
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
            ),
            //Para deixar esse FlatButton alinhado 
            //à esquerda, podemos ou na column que está
            //em volta dele colocar o alinhamento do 
            //cross axis para start, ou se for só este
            //botão e não queremos mudar mais nenhum
            //elemento de posição dentro da coluna, basta
            //fazer um wrap neste FlatButton com um Align e 
            //setar o alinhamento para bottomLeft por 
            //exemplo, ou ainda fazer um wrap nele com uma
            //Row por exemplo e arrumar seu alinhamento de
            //main axis ou com uma Column e mexer no 
            //cross axis.
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlatButton(
                  child: Text(
                    'Nova Transação'
                  ),
                  textColor: Colors.purple,
                  onPressed: _submitForm
                ),
              ],
            )
          ]
        ),
      )
    );
  }
}