import 'package:borderwander/widgets/auth_widgets/top.dart';
import 'package:flutter/material.dart';

class WelcomScreen extends StatelessWidget {
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
                    "Vitajte",
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
                  "Cieľom tejto aplikácie je motivovať ľudí k pohybu, a to hravou a súťaživou fomou. Vašou úlohou bude zaberanie si územia v reálnom svete",
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
