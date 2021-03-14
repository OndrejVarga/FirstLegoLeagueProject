import '../widgets/auth_widgets/auth_form_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const routeName = 'auth';
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    Color color,
    bool isLogIn,
    BuildContext context,
    int weight,
  ) async {
    UserCredential authResult;
    setState(() {
      _isLoading = true;
    });

    try {
      if (isLogIn) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user.uid)
            .set({
          'username': username,
          'email': email,
          'color': color.value,
          'currAreaOfTerritory': 0,
          'length': 0,
          'tutorial': false,
          'ownedColors': [color.value],
          'points': 0,
          'totalSteps': 0,
          'weight': weight,
          'calories': 0
        });
      }
    } catch (err) {
      var message = 'Nastala chyba skontrolujte si svoje údaje';
      if (err.message != null) {
        message = err.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Junior App'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  margin: const EdgeInsets.all(20),
                  height: 100,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                  )),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: AuthForm(_submitAuthForm, _isLoading)),
            ],
          ),
        ),
      ),
    );
  }
}
