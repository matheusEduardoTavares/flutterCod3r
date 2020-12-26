import 'components/transaction_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//Pacote de internacionalização que importamos no 
//pubspec.yaml para poder padronizar a formatação da
//data:
import 'package:intl/intl.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context){
    //Definindo o locale default antes de inserir os 
    //localizationsDelegates. Com esse locale default
    //não é preciso passar pt_BR na hora de fazer a 
    //formatação pois esse já será o default.

    Intl.defaultLocale = 'pt_BR';
    
    return MaterialApp(
      title: 'ExpensesApp',
      //Importamos no pubspec.yaml o flutter_localizations
      //assim:
      //   flutter_localizations:
      //      sdk: flutter
      //importamos aqui esse pacote para termos acesso ao
      //GlobalMaterialLocalizations e ao 
      //GlobalWidgetsLocalizations
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('pt', 'BR')
      ],
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatelessWidget {
  //Não é indicado ter variáveis que não sejam final 
  //dentro de um componente stateless.

  //Mesmo marcando a variável como final, ainda sim 
  //iremos precisar alterar o estado interno dessa
  //variável, e não é bom mesmo que temos um atributo 
  //final mas que dentro deste atributo, é uma classe que
  //os estados internos dessa classe vão estar alterando,
  //o ideal ainda assim é colocar dentro de um componente
  //stateful;
  // final titleController = TextEditingController();
  // final valueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        centerTitle: true,
      ),
      //Usando o SingleChildScrollView irá funcionar de 
      //forma a fazer scroll e não quebrar quando o tamanho
      //da altura é sobreposto. Isso só funciona aqui pois
      //essa coluna tem um pai com tamanho pré-definido,
      //no caso o body do Scaffold tem um tamanho pré-
      //definido e por isso funciona.
      body: SingleChildScrollView(
        child: Column(
          //A coluna coloca como default o alinhamento do
          //eixo X como centro, então podemos mudar isso caso
          //queremos que comece no início:
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Para fazer o card ocupar todo espaço horizontal
            //da tela, podemos fazer um wrap dele em um 
            //Container e definir o width do container como
            //double.infinity, ou melhor ainda, é só fazer
            //a column ter CrossAxisAlignment.stretch .
            Container(
              child: Card(
                color: Colors.blue,
                child: Text('Gráfico'),
                //O elevation serve para dar uma noção de 
                //de 3D para destacar aquele (eixo z)
                //card, aumentando o sombreamento o quanto
                //maior for o valor do elevation (double)
                elevation: 5
              ),
            ),
            TransactionUser()
          ]
        ),
      )
    );
  }
}