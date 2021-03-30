import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/exceptions/auth_exception.dart';
import 'package:shop/providers/auth.dart';

enum AuthMode {
  Signup,
  Login
}

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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Ocorreu um erro!'),
        content: Text(message),
        actions: [
          FlatButton(
            child: Text('FECHAR'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!(_formKey?.currentState?.validate() ?? false)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState.save();

    final auth = Provider.of<Auth>(context, listen: false);

    try {
      if (_authMode == AuthMode.Login) {
        await auth.login(
          _authData['email'], 
          _authData['password']
        );
      } else {
        await auth.signup(
          _authData['email'], 
          _authData['password']
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
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

    return Flexible(
      child: Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SingleChildScrollView(
            child: Container(
              width: deviceSize.width * 0.75,
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'E-mail'
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
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
                    const SizedBox(height: 40),
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
          ),
        ),
      ),
    );
  }
}