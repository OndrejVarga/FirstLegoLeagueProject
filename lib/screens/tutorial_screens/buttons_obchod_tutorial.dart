import 'package:flutter/material.dart';

class ButtonObchod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: const Text(
              'Základné ovládanie Obchodu',
              style: const TextStyle(
                  color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),textAlign: TextAlign.center
            ),
          ),
          const SizedBox(height: 20, width: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: const Text(
              'V obchode si môžete zakúpiť nové farby',
              style: const TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.center
            ),
          ),
          Container(
              margin: const EdgeInsets.all(20),
              height: 200,
              child: Image.asset(
                'assets/images/farba.png',
                fit: BoxFit.cover,
              )),
          Padding(
            padding: const EdgeInsets.all(20),
            child: const Text('A dozvedieť sa viac o vašich územiach',
                style: const TextStyle(color: Colors.white, fontSize: 20),textAlign: TextAlign.center),
          ),
               const SizedBox(height: 400),
        ],
        
    
    );
  }
}
