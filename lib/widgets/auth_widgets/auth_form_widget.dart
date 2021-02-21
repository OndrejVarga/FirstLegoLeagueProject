import '../auth_widgets/auth_form_color_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(
      String email,
      String password,
      String username,
      Color color,
      bool isLogIn,
      BuildContext context,
      int weight) submitAuthForm;
  final bool isLoading;

  AuthForm(this.submitAuthForm, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _username = '';
  int _weight = 0;
  bool _isLogIn = true;
  Color _currentColor = Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => _currentColor = color);
  }

  void _trySubmit() {
    final validated = _formKey.currentState.validate();
    if (validated) {
      if (_weight < 10 && !_isLogIn) {
        print(_isLogIn);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text("Pozor"),
                  content: Text("Nezadal si hmotnosť"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
      } else {
        _formKey.currentState.save();
        widget.submitAuthForm(_email, _password, _username, _currentColor,
            _isLogIn, context, _weight);
      }

      FocusScope.of(context).unfocus();
      _formKey.currentState.save();
    }
  }

  TextEditingController _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Zadajte svoju hmotnosť (kg)'),
          content: TextField(
            keyboardType: TextInputType.number,
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: "Hmotnosť"),
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('Nechcem uviesť'),
              onPressed: () {
                _weight = 80;
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: const Text('Ok'),
              onPressed: () {
                _weight = int.parse(_textFieldController.text);
                if (_weight > 0) {
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      color: Theme.of(context).cardColor,
      margin: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  key: const ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelStyle: const TextStyle(color: Colors.white),
                    labelText: 'Email',
                  ),
                  onSaved: (value) {
                    _email = value;
                  },
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Prosím zadajte platný email';
                    }
                    return null;
                  },
                ),
                if (!_isLogIn)
                  TextFormField(
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    key: const ValueKey('username'),
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                        labelText: 'Meno',
                        labelStyle: const TextStyle(color: Colors.white)),
                    onSaved: (value) {
                      _username = value;
                    },
                    validator: (value) {
                      if (value.isEmpty || value.length < 4) {
                        return 'Meno musí obsahovať najmenej 4 znaky';
                      }
                      return null;
                    },
                  ),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  key: const ValueKey('password'),
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Heslo',
                      labelStyle: const TextStyle(color: Colors.white)),
                  onSaved: (value) {
                    _password = value;
                  },
                  //Kontrola textu zadaného do poľa
                  validator: (value) {
                    if (value.isEmpty || value.length < 7) {
                      return 'Heslo musí byť minimálne 7 znakov dlhé';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                if (!_isLogIn)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorPickerWidget(changeColor, _currentColor),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 150,
                        height: 38.0,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: _currentColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 15,
                ),
                if (!_isLogIn)
                  RaisedButton(
                    onPressed: () {
                      _displayTextInputDialog(context);
                    },
                    child: Text("Hmotnosť"),
                  ),
                const SizedBox(
                  height: 15,
                ),
                RaisedButton(
                  onPressed: _trySubmit,
                  child: widget.isLoading
                      ? CircularProgressIndicator()
                      : Text(_isLogIn ? "Prihlásiť sa" : "Zaregistrovať sa"),
                ),
                if (!widget.isLoading)
                  FlatButton(
                    onPressed: () {
                      setState(() {
                        _isLogIn = !_isLogIn;
                      });
                    },
                    child:
                        Text(_isLogIn ? "Vytvoriť nový účet" : "Už mám účet"),
                    textColor: Colors.white,
                  ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
