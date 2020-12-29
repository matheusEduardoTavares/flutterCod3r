import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef AddTransaction = void Function(String, double, DateTime);

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
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null){
      return;
    }

    //O atributo widget é recebida por herança e ele aponta
    //para uma instância da classe que está como
    //StatefulWidget e ele tem no caso o método onSubmit,
    //pois todos os atributos / métodos daquela classe 
    //poderão ser acessados por meio desse atributo 
    //widget
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() async {
    DateTime pickedDate = await showDatePicker(
      //Como estamos dentro de uma classe que extende de
      //State, temos acesso a alguns atributos que vem 
      //por heraça, um deles é o widget para referenciar
      //os atributos e métodos da classe stateful que é 
      //referente a esta classe state, e o outro é o 
      //context
      context: context,
      initialDate: DateTime.now(),
      //O firstDate é a data inicial que o usuário consegue
      //selecionar, que usando o construtor do DateTime 
      //passando apenas um parâmetro posicional, passamos a
      //data e a data inicial que será usada é 01/01/[parâmetro],
      //resumindo, é a data mais antiga que o usuário poderá
      //selecionar.
      firstDate: DateTime(2019),
      //Não permitir selecionar datas no futuro:
      lastDate: DateTime.now(),
    );

    if (pickedDate == null) return ;

    setState(() {
      _selectedDate = pickedDate;
    });
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
              controller: _titleController,
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
              controller: _valueController,
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
                  Expanded(
                    child: Text(
                      _selectedDate == null ? 'Nenhuma data selecionada!' :
                      'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}'
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      'Selecionar Data', 
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      )
                    ),
                    onPressed: _showDatePicker,
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