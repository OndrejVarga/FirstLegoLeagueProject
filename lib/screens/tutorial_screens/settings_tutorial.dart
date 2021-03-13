import 'package:flutter/material.dart';

class Nastavenia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Základné Nastavenia',
          style: const TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),textAlign: TextAlign.center
        ),
        const SizedBox(height: 40, width: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: const Text(
            'Nastavenia si môžete zmeniť v pravom hornom rohu',
            style: const TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.center
          ),
        ),
        const SizedBox(height: 40, width: 30),
        const Text(
          'Automatické Sledovanie',
          style: const TextStyle(color: Colors.white, fontSize: 30),textAlign: TextAlign.center
        ),
        const SizedBox(height: 30, width: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: const Text(
            'Mapa sa bude prispôsobovať vášmu pohybu',
            style: const TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.center
          ),
        ),
        const SizedBox(height: 40, width: 20),
        const Text('Len svoje uzemia',
            style: const TextStyle(color: Colors.white, fontSize: 30),textAlign: TextAlign.center),
        const SizedBox(height: 10, width: 20),
        const Text('Na mape uvidíte len svoje územia',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        const SizedBox(height: 40, width: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
              'POZOR NA ODCHOD Z APLIKÁCIE POUŽITE MOŽNOSŤ V NASTAVENIACH',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red, fontSize: 32)),
        ),
         const SizedBox(height: 400),
      ],
    );
  }
}
