import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

typedef ShowDatePicker = void Function(DateTime);

class AdaptativeDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final ShowDatePicker onDateChanged;

  const AdaptativeDatePicker({
    @required this.selectedDate,
    @required this.onDateChanged
  });

  _showDatePicker(BuildContext context) async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );

    onDateChanged(pickedDate);
  }

  @override
  Widget build(BuildContext context) {
    //Toda lógica no caso do android desenvolvemos 
    //usando o showDatePicker, mas no caso do iOS 
    //sua lógica é desenvolvida no seu próprio 
    //widget, o CupertinoDatePicker. 
    //Mas precisaremos da função para dar o setState 
    //para o CupertinoDatePicker também, mas não será
    //preciso do showDatePicker e o resto da lógica 
    //desenvolvida na mão como fizemos.
    //Além disso,o CupertinoDatePicker precisa estar 
    //dentro de uma área que tem um tamanho específico 
    //se não dará um problema. Então podemos envolvê-lo
    //com um container e deifinir uma altura.
    //Em relação ao 
    //showDatePicker e o CupertinoDatePicker, 
    //seus parâmetros são parecidos, do CupertinoDatePicker,
    //temos o mode que é que datas queremos, se tem 
    //horas também ou só horas, temos também o 
    //initialDateTime que é o initialDate do showDatePicker,
    //o minimumDate é o firstDate, o maximumDate é o 
    //lastDate
    return Platform.isIOS ? Container(
      height: 180,
      child: CupertinoDatePicker(
        //setamos o mode para pegar apenas data e não hora
        mode: CupertinoDatePickerMode.date,
        initialDateTime: DateTime.now(),
        minimumDate: DateTime(2019),
        maximumDate: DateTime.now(),
        onDateTimeChanged: onDateChanged,
      ),
    ) : Container(
      height: 70,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              selectedDate == null ? 'Nenhuma data selecionada!' :
              'Data Selecionada: ${DateFormat('dd/MM/y').format(selectedDate)}'
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
            onPressed: () => _showDatePicker(context),
          )
        ],
      ),
    );
  }
}