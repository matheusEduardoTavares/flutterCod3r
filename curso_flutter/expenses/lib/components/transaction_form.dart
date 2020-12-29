import 'package:flutter/material.dart';

typedef AddTransaction = void Function(String, double);

//Convertermos de StatelessWidget para StatefulWidget
//pois os TextEditingController possuem um estado interno
//e sempre que o usuário digitava algo em algum textfield
//e trocada de campo ou clicava para confirmar no teclado,
//aquele dado era perdido pois o mesmo era atualizado mas
//não refletia na UI. Então só de alterar para Stateful
//Widget já volta a funcionar.
class TransactionForm extends StatefulWidget {
  final AddTransaction onSubmit;

  TransactionForm({
    @required this.onSubmit,
  });

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  void _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0){
      return;
    }

    //O atributo widget é recebida por herança e ele aponta
    //para uma instância da classe que está como
    //StatefulWidget e ele tem no caso o método onSubmit,
    //pois todos os atributos / métodos daquela classe 
    //poderão ser acessados por meio desse atributo 
    //widget
    widget.onSubmit(title, value);
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
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text('Nenhuma data selecionada!'),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Selecionar Data', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      )
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  child: Text(
                    'Nova Transação'
                  ),
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
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