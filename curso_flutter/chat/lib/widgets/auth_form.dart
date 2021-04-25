import 'dart:io';

import 'package:chat/models/auth_data.dart';
import 'package:chat/widgets/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  const AuthForm(
    this.onSubmit,
  );

  final void Function(AuthData) onSubmit;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  var _isVisiblePassword = true;
  final AuthData _authData = AuthData();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    final isValid = _formKey?.currentState?.validate() ?? false;
    if (isValid) {
      FocusScope.of(context).unfocus();

      if(_authData.image == null && _authData.isSignup) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Precisamos da sua foto!'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );

        return;
      }

      widget.onSubmit(_authData);
    }
    else {
      print('inválido');
    }
  }

  void _handlePickedImage(File image) {
    _authData.image = image;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (_authData.isSignup)
                    UserImagePicker(_handlePickedImage),
                  if (_authData.isSignup)
                    TextFormField(
                      autocorrect: true,
                      textCapitalization: TextCapitalization.words,
                      key: ValueKey('name'),
                      enableSuggestions: false,
                      initialValue: _authData.name,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                      ),
                      onChanged: (value) => _authData.name = value,
                      validator: (value) {
                        if (value == null || value.trim().length < 4) {
                          return 'Nome deve ter no mínimo 4 caracteres';
                        }

                        return null;
                      }
                    ),
                  TextFormField(
                    autocorrect: false,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: false,
                    key: ValueKey('email'),
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onChanged: (value) => _authData.email = value,
                    validator: (value) {
                      if (value == null || !value.contains('@')) {
                        return 'Forneça um e-mail válido';
                      }

                      return null;
                    }
                  ),
                  TextFormField(
                    key: ValueKey('password'),
                    obscureText: _isVisiblePassword,
                    validator: (value) {
                      if (value == null || value.trim().length < 7) {
                        return 'Senha deve ter no mínimo 7 caracteres';
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      suffixIcon: IconButton(
                        icon: Icon(_isVisiblePassword ? 
                          Icons.visibility : Icons.visibility_off
                        ),
                        onPressed: () => setState(() { _isVisiblePassword = !_isVisiblePassword; }),
                        color: _isVisiblePassword ? 
                          Theme.of(context).accentColor : Colors.grey,
                      ),
                    ),
                    onChanged: (value) => _authData.password = value,
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    child: Text(_authData.isLogin ? 'Entrar' : 'Cadastrar'),
                    onPressed: _submit,
                  ),
                  TextButton(
                    child: Text(_authData.isLogin ? 'Criar uma nova conta?' :
                      'Já possui uma conta?'),
                    onPressed: () {
                      setState(() {
                        _authData.toggleMode();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}