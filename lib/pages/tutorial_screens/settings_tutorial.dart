import 'package:borderwander/providers/data_fetcher.dart';
import 'package:borderwander/widgets/auth_widgets/top.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Nastavenia extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AuthTop(),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            "Posledné tipy!",
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(fontSize: 30),
                          ),
                        ),
                        Image.asset(
                          'assets/images/Logo1.png',
                          height: 45,
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      child: Text(
                        'Ak sa vám podarí získavať územie pravidelne každý deň počas aspoň 30 dní, získate pred svoje meno korunku.',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(fontSize: 25),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      child: Text(
                        'Pre odchod z aplikácie použite odkaz v nastaveniach.',
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(fontSize: 25),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 25),
                      child: Text(
                        'Maximálna povolená rýchlosť je ${Provider.of<DataFetcher>(context, listen: false).settings['maxSpeed']} km/h.',
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
          ),
        ),
      ),
    );
  }
}
