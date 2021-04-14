import 'package:chat/screens/auth_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurple,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.pink,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        ///Com o [accentColorBrightness] podemos explicitar
        ///para o Flutter se a cor que escolhemos do 
        ///[accentColor] é uma cor escura ou uma cor clara,
        ///para que seja contrastado outras cores 
        ///dependendo do que for colocado nesse 
        ///[accentColorBrightness]. Passamos para ele ou
        ///[rightness.dark] ou [rightness.light]. Não é 
        ///necessário fazer isso com a cor primária, mas com
        ///o [accentColor] é importante fazer
        accentColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthScreen(),
    );
  }
}