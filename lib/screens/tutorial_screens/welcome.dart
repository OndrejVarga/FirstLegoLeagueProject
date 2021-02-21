import 'package:flutter/material.dart';

class WelcomScreen extends StatelessWidget {
  static const routeName = 'Welcome';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Vitajte",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 100),
        Container(
            //logo školy
            margin: const EdgeInsets.all(20),
            height: 100,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.cover,
            )),
      ],
    );
  }
}
