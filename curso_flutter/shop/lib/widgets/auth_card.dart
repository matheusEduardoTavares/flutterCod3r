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
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final _authData = <String, String>{
    'email': '',
    'password': ''
  };

  void _submit() {
    if (!(_formKey?.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    ///Como já sabemos o método [save] irá chamar o [onSaved]
    ///de todos os [TextFormField] dentro do [Form] relacionado,
    ///que por sua vez setará os dados em [_authData]
    _formKey.currentState.save();

    if (_authMode == AuthMode.Login) {
      // Login
    } else {
      // Registrar
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode =AuthMode.Signup;
      });
    }
    else {
      setState(() {
        _authMode =AuthMode.Login;
      });
    }
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
        height: _authMode == AuthMode.Login ? 290 : 371,
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
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
                    else if (value.isEmpty) {
                      return 'Senha vazia!';
                    }

                    return null;
                  } : null,
                ),
              const Spacer(),
              if (_isLoading)
                CircularProgressIndicator()
              else
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
              FlatButton(
                onPressed: _switchAuthMode,
                child: Text(
                  'ALTERNAR P/ '
                  '${_authMode == AuthMode.Login ? 'REGISTRAR' : 'LOGIN'}'
                ),
                textColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}