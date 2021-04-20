import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/auth_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override 
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> _handleSubmit(AuthData newAuthData) async {
    final _auth = FirebaseAuth.instance;

    try {
      if (newAuthData.isLogin) {
        await _auth.signInWithEmailAndPassword(
          email: newAuthData.email.trim(),
          password: newAuthData.password,
        );
      }
      else {
        await _auth.createUserWithEmailAndPassword(
          email: newAuthData.email.trim(),
          password: newAuthData.password,
        );
      }
      ///Caso ocorra algum erro no Firebase, será 
      ///gerado a [Exception] [PlatformException]
    } on PlatformException catch (err) {
      final msg = err.message ?? 'Ocorreu um erro! Verifique suas credenciais!'; 
      ///Aqui iremos mostrar a variável [msg] em uma 
      ///[SnackBar] contendo o erro encontrado. Isso 
      ///seria bem fácil se estivéssemos em uma tela que
      ///fosse filha de [Scaffold], ou seja, tivesse 
      ///um [BuildContext] próprio, fosse um [Stateless]
      ///ou um [Stateful]. Porém, não é o caso, então 
      ///para resolver isso nas versões mais antigas do a 
      ///Flutter, temos que passar para o 
      ///[Scaffold] uma [key] sendo um [GlobalKey<ScaffoldState>],
      ///aí para o objeto que tem essa instância da chave 
      ///global, pegamos o atributo [.currentState] e a 
      ///partir daqui temos acesso aos métodos referentes
      ///à [SnackBar], como [showSnackBar()], e então usamos
      ///esse objeto ao invés de usar o [Scaffold.of(context)],
      ///para acessar os métodos referentes ao [SnackBar].
      ///Já nas versões mais recentes do Flutter, 
      ///esse problema foi resolvido, 
      ///bastando usar o [ScaffoldMessenger.of(context)], 
      ///sendo que ele funciona igual ao [Scaffold.of(context)]
      ///e independente de onde será chamado a [SnackBar]
      // _scaffoldKey.currentState.showSnackBar(...)
      ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: Text(msg),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
    }
    catch (err) {
      print(err);
    }
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _handleSubmit,
      ),
    );
  }
}