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
    //Queremos fazer com que caso aumentemos a dimensão
    //do container que contém o Chart como child no main.dart,
    //as barras dos gráficos também cresçam para acompanhar
    //essa mudança de tamanho. Paara isso precisamos pegar
    //o tamanho do contexto que ele está inserido, e não
    //o tamanho da tela em si. É complicado fazer a lógica
    //matemática caso usemos o tamanho da tela. Para fazer
    //isso, iremos fazer um wrap da column com um Layout
    //Builder, aí usamos o atributo builder dele para
    //retornar o widget que queremos. Essa função tem
    //2 parâmetros, o contexto e uma constraint, e a
    //partir dessas constraints conseguimos pegar a 
    //informação do tamanho no qual estamos dentro do 
    //contexto desse component que será criado. O 
    //constraints.maxHeight irá fornecer toda essa altura
    //disponível.
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return Column(
          children: <Widget>[
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  ' ${value.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 12
                  )
                ),
              ),
            ),
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              //Colocando apenas o height usando as 
              //constraints aqui, caso esteja 50% para o
              //Chart e para o TransactionList no 
              //main.dart irá funcionar dependendo do 
              //tamanho do dispositivo. Mas dependendo
              //do tamanho ou do valor dessa porcentagem
              //usada irá dar problema de sobrepor o 
              //tamanho das barras em relação ao card.
              //Esse problema acontece pois estamos 
              //misturando percentual com valores fixos 
              //que no caso é o valor, do dia da semana
              //e dos sizedBox.
              //O ideal é trabalhar com todos elementos 
              //com tamanhos fixos ou todos com percentual.
              //No caso dos textos para evitar que algo 
              //quebre é importante usar o FittedBox 
              //em volta dele.
              height: constraints.maxHeight * 0.6,
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
            SizedBox(height: constraints.maxHeight * 0.05),
            Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                child: Text(label)
              ),
            ),
          ]
        );
      },
    );
  }
}