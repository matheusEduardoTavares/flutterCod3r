import 'package:flutter/material.dart';

///Se ela está em modo de criação de conta ou de login
enum AuthMode {
  Signup,
  Login
}

///Esse componente será [StatfulWidget] pois precisará controlar
///se está no estado de autenticação de login ou de criação de
///conta
class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  final _passwordController = TextEditingController();
  var _authMode = AuthMode.Login;

  final _authData = <String, String>{
    'email': '',
    'password': ''
  };

  void _submit() {
    
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: 320,
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail'
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  ///Poderíamos fazer essa validação usando 
                  ///[RegExp] que ficaria melhor, e poderíamos
                  ///até mesmo externalizar essas validações,
                  ///criando dentro da pasta utils uma classe
                  ///validator e que tem uma função que recebe
                  ///um e-mail e eventualmente a mensagem de 
                  ///erro caso o e-mail não seja válido.
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Informe um e-mail válido!';
                  }

                  return null;
                },
                onSaved: (value) => _authData['email'] = value,
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha'
                ),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty || value.length < 5) {
                    return 'Informe uma senha válida!';
                  }

                  return null;
                },
                onSaved: (value) => _authData['password'] = value,
              ),
              if (_authMode == AuthMode.Signup)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha'
                  ),
                  obscureText: true,
                  ///Para evitar que em modo [AuthMode.Login]
                  ///seja usado o validator, iremos criar uma
                  ///condicional aqui também
                  validator: _authMode == AuthMode.Signup ? (value) {
                    if (value != _passwordController.text) {
                      return 'Senhas são diferentes!';
                    }

                    return null;
                  } : null,
                ),
              const SizedBox(height: 20),
              RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryTextTheme.button.color,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 8,
                ),
                child: Text(
                  _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
                ),
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}