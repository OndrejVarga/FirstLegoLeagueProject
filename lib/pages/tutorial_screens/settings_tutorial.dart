import 'package:borderwander/widgets/auth_widgets/top.dart';
import 'package:flutter/material.dart';

class Nastavenia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AuthTop(),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Posledné typy!",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontSize: 35),
                  ),
                  Image.asset(
                    'assets/images/Logo1.png',
                    height: 45,
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  'Ak sa Vám podarí získavať územie pravidelne každý deň, po dobu aspoň 30 dní, získate pred svoje meno Korunku',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 25),
                  textAlign: TextAlign.start,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Text(
                  ' Pre odchod z aplikácie použite odkaz v nastaveniach',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 25),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
