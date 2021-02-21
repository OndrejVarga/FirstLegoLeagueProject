import 'package:FLL/screens/tutorial_screens/buttons.dart';
import 'package:FLL/screens/tutorial_screens/territory.dart';
import 'package:FLL/screens/tutorial_screens/welcome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TutorialTutorial extends StatefulWidget {
  static const routeName = 'tut';
  @override
  _TutorialTutorialState createState() => _TutorialTutorialState();
  int currIndex = 0;
}

List<Widget> tutorial = [
  WelcomScreen(),
  TerritoryTutorial(),
  ButtonTutorial(),
];

class _TutorialTutorialState extends State<TutorialTutorial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              tutorial[widget.currIndex],
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          if (widget.currIndex + 1 == tutorial.length) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .update({'tutorial': true});

                            Navigator.of(context).pop();
                          } else {
                            widget.currIndex++;
                          }
                        });
                      },
                      child: const Text(
                        'Ďalej',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
