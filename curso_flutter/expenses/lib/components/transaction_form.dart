import 'package:flutter/material.dart';
import 'adaptative_date_picker.dart';
import 'adaptative_button.dart';
import 'adaptative_textfield.dart';

typedef AddTransaction = void Function(String, double, DateTime);
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

    widget.onSubmit(title, value, _selectedDate);
  }

  @override 
  Widget build(BuildContext context){
    //Estávamos tendo um problema que quando estamos 
    //selecionados em um dado TextField e queiramos ir 
    //para o TextField de baixo não conseguimos a não 
    //ser fechando o showModalBottomSheet, e isso ocorre
    //pois o teclado fica por cima do conteúdo dele.
    //Para resolver isso, pegaremos o tamanho do teclado
    //e faremos com que a margem de baixo seja esse tamanho
    //+ 10, de forma que podemos usar um SingleChildScrollView
    //em volta para caso o tamanho do modal acabe estrapolando
    //o tamanho da tela, e assim usamos uma solução simples
    //para resolver este problema, mas que não é a 
    //melhor solução.
    //Conseguimos o tamanho do teclado a partir de:
    //MediaQuery.of(context).viewInsets.bottom
    //O viewInsets são as dimensões da view, da nossa
    //tela. Quando o teclado aparece, a view fica menor,
    //então o espaço bottom é exatamente o mesmo tamanho
    //do teclado uma vez que ele sobe, ou seja, a view 
    //em baixo fica com o espaçamento exatamente do 
    //tamanho do teclado.
    //Para implementar da forma certa agora, será 
    //tirado o wrap do Padding em volta da Column,
    //e onde é chamado o TransactionForm foi 
    //feito um wrap do TransactionForm com 
    //um Padding adicionando um padding apenas
    //em baixo com o valor do tamanho do 
    //teclado, e foi adicionado a propriedade
    //isScrollControlled: true no 
    //showModalBottomSheet 
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget> [
            AdaptativeTextField(
              controller: _titleController,
              // androidDecoration: InputDecoration(
              //   labelText: 'Título'
              // ),
              label: 'Título',
              onSubmitted: (_) => _submitForm(),
              placeholder: 'Título',
            ),
            AdaptativeTextField(
              controller: _valueController,
              // androidDecoration: InputDecoration(
              //   labelText: 'Valor (R\$)'
              // ),
              label: 'Valor (R\$)',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              placeholder: 'Título',
            ),
            AdaptativeDatePicker(
              selectedDate: _selectedDate, 
              onDateChanged: (newDate) {
                if (newDate == null) return ;

                setState(() {
                  _selectedDate = newDate;
                });
              }
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdaptativeButton(
                  label: 'Nova Transação',
                  onPressed: _submitForm
                ),
              ],
            )
          ]
        )
      ),
    );
  }
}