import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({
      this.label, 
      this.value, 
      this.percentage
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //Mesmo colocando o Flexible com o FlexFit.tight 
        //como wrap dos ChartBar, caso o valor seja muito
        //grande ele acaba ocupando mais de uma linha e isso
        //não é o que queremos. Para resolver fazemos um 
        //wrap do Text com um FittedBox. Só de fazer isso, 
        //o tamanho do texto será diminuído para poder caber
        //no tamanho disponível para ele.
        //Porém quando o valor for muito grande vai causar
        //um certo desalinhamento com os demais itens e para
        //resolver isso basta fazer um wrap do FittedBox
        //com um container e definir uma altura fixa
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              ' ${value.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 12
              )
            ),
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 60,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget> [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0
                  ),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(5),
                )
              ),
              //É um SizedBox fracionado, em que definimos 
              //as dimensões a partir de uma porcentagem
              FractionallySizedBox(
                heightFactor: percentage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(5),
                  )
                ),
              )
            ]
          )
        ),
        SizedBox(height: 5),
        Text(label),
      ]
    );
  }
}