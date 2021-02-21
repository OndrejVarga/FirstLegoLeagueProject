import 'package:flutter/material.dart';

class ButtonTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text(
            'Základné ovládanie',
            style: const TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20, width: 20),
          const Text(
            'Územie začnete zaberať stlačením',
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Container(
              margin: const EdgeInsets.all(20),
              height: 100,
              child: Image.asset(
                'assets/images/start.png',
                fit: BoxFit.cover,
              )),
          const Text('Nastavenia si zmeníte stlačením',
              style: const TextStyle(color: Colors.white, fontSize: 20)),
          const Text('Pre vypnutie aplikácie použite možnosť v nastaveniach',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 10)),
          Container(
              margin: const EdgeInsets.all(20),
              height: 100,
              child: Image.asset(
                'assets/images/set.png',
                fit: BoxFit.cover,
              )),
          const Text('Porovnajte sa s ostatnými v tabuľke',
              style: const TextStyle(color: Colors.white, fontSize: 20)),
          Container(
              margin: const EdgeInsets.all(20),
              height: 100,
              child: Image.asset(
                'assets/images/nav.png',
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }
}
