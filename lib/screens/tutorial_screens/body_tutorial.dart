import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Body ',
          style: const TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20, width: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: const Text(
              'Za zaberanie územia získavate body, za ktoré si môžete nakupovať farby, ktorými si môžete upravovať výzor vašich území ',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              textAlign: TextAlign.center),
        ),
        Container(
            //logo školy
            margin: const EdgeInsets.all(20),
            height: 200,
            child: Image.asset(
              'assets/images/farba.png',
              fit: BoxFit.cover,
            )),
        const Text(' ',
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center),
        const Text('Váš výkon bude zobrazený v tabuľke',
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center),
        Container(
            //logo školy
            margin: const EdgeInsets.all(20),
            child: Image.asset(
              'assets/images/tabulka.png',
              fit: BoxFit.cover,
            )),
      ],
    );
  }
}
