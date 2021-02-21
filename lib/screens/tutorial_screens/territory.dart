import 'package:flutter/material.dart';

class TerritoryTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'Vašou úlohou bude',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20, width: 20),
            const Text(
              'Získať územie',
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            Container(
                //logo školy
                margin: const EdgeInsets.all(20),
                height: 100,
                child: Image.asset(
                  'assets/images/create.gif',
                  fit: BoxFit.cover,
                )),
            const Text('Zväčšovať si ho',
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            Container(
                //logo školy
                margin: const EdgeInsets.all(20),
                height: 100,
                child: Image.asset(
                  'assets/images/extend.gif',
                  fit: BoxFit.cover,
                )),
            const Text('A zaberať ho ostatným',
                style: const TextStyle(color: Colors.white, fontSize: 20)),
            Container(
                //logo školy
                margin: const EdgeInsets.all(20),
                height: 100,
                child: Image.asset(
                  'assets/images/take.gif',
                  fit: BoxFit.cover,
                )),
          ],
        ),
      ),
    );
  }
}
