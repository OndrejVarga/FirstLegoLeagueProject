import 'package:flutter/material.dart';

class DataKtoreViem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Center(
            child: const Text('Pre milovníkov údajov',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          ),
          const SizedBox(height: 20, width: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: const Text('Pri vašom zaberaní územia si môžete pozrieť:',
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center),
          ),
          Container(
              //logo školy
              margin: const EdgeInsets.all(20),
              child: Image.asset(
                'assets/images/data.png',
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }
}
