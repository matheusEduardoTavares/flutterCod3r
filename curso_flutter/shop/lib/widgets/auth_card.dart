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

class _AuthCardState extends State<AuthCard> with SingleTickerProviderStateMixin {
  final _passwordController = TextEditingController();
  var _authMode = AuthMode.Login;
  var _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  AnimationController _controller;
  Animation<double> _opacityAnimation;
  Animation<Offset> _slideAnimation;

  @override 
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        curve: Curves.linear,
        parent: _controller,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

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
        _authMode = AuthMode.Signup;
      });
      _controller.forward();
    }
    else {
      setState(() {
        _authMode = AuthMode.Login;
      });
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: Card(
            elevation: 8.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.linear,
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
                    AnimatedContainer(
                      constraints: BoxConstraints(
                        minHeight: _authMode == AuthMode.Signup ? 60 : 0,
                        maxHeight: _authMode == AuthMode.Signup ? 120 : 0,
                      ),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.linear,
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: TextFormField(
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
                        ),
                      ),
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
      ],
    );
  }

  @override 
  void dispose() {
    _controller.dispose();

    super.dispose();
  }
}