import 'package:flutter/material.dart';

class ButtonObchod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text('Základné ovládanie Obchodu',
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 35)),
        ),
        const SizedBox(height: 20, width: 20),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('V obchode si môžete zakúpiť nové farby',
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 35)),
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
          child: Text('Zmeniť výzor svojho avatara',
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 35)),
        ),
      ],
    );
  }
}
