import 'package:flutter/material.dart';
import 'adaptative_date_picker.dart';
import 'adaptative_button.dart';
import 'adaptative_textfield.dart';

typedef AddTransaction = void Function(String, double, DateTime);
class TransactionForm extends StatefulWidget {
  final AddTransaction onSubmit;

  TransactionForm({
    @required this.onSubmit,
  }) {
    print('Constructor TransactionForm');
  }

  @override
  _TransactionFormState createState() {
    print('createState TransactionForm');
    return _TransactionFormState();
  }
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _TransactionFormState() {
    print('Constructor _TransactionFormState');
  }

  @override 
  void initState(){
    super.initState();

    print('initState _TransactionFormState');
  }

  @override 
  void didUpdateWidget(TransactionForm oldWidget){
    super.didUpdateWidget(oldWidget);
    //widget é o componente novo, o atual, enquanto 
    //o oldWidget é o componente velho.

    print('didUpdateWidget _TransactionFormState');
  }

  @override 
  void dispose(){
    super.dispose();

    print('dispose _TransactionFormState');
  }

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
    print('build() TransactionForm');
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget> [
            AdaptativeTextField(
              controller: _titleController,
              label: 'Título',
              onSubmitted: (_) => _submitForm(),
              placeholder: 'Título',
            ),
            AdaptativeTextField(
              controller: _valueController,
              label: 'Valor (R\$)',
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
              placeholder: 'Valor (R\$)',
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