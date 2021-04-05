import 'package:borderwander/providers/data_fetcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonMapa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Základné ovládanie Mapy',
          style: const TextStyle(
              color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20, width: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: const Text(
            'Vaše územia sa zobrazujú na mape',
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
            margin: const EdgeInsets.all(20),
            height: 200,
            child: Image.asset(
              'assets/images/mapa.png',
              fit: BoxFit.cover,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: const Text(
            'Svoje územie začnete a skončíte zaberať stlačením',
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
            margin: const EdgeInsets.all(20),
            height: 100,
            child: Image.asset(
              'assets/images/start.png',
              fit: BoxFit.cover,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Text(
              'Pozor najvyššia povolená priemerná rýchlosť je ${Provider.of<DataFetcher>(context, listen: false).settings['maxSpeed']} km/h',
              style: const TextStyle(color: Colors.red, fontSize: 20),
              textAlign: TextAlign.center),
        ),
        const SizedBox(height: 400),
      ],
    );
  }
}
