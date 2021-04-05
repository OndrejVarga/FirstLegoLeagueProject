import 'package:borderwander/pages/goodbye.dart';
import 'package:borderwander/pages/tutorial_screens/tutorial.dart';
import 'package:borderwander/providers/core.dart';
import 'package:borderwander/providers/data_fetcher.dart';
import 'package:borderwander/utils/error_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MapDrawer extends StatefulWidget {
  final Function stop;

  MapDrawer(this.stop);

  @override
  _MapDrawerState createState() => _MapDrawerState();
}

class _MapDrawerState extends State<MapDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 130,
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 20, bottom: 10),

                      //Title---------------------------------------------------
                      child: Text(
                        'Nastavenia',
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .copyWith(fontSize: 25),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        //Settings--------------------------------------------------
                        //Len Svoje uzemia------------------------------------------
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Len svoje územie',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(fontSize: 18),
                                ),
                              ),
                              Switch(
                                value:
                                    Provider.of<Core>(context).lenSvojeUzemie,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      Provider.of<Core>(context, listen: false)
                                          .changeLenSvojeUzemie();
                                    },
                                  );
                                },
                              )
                            ],
                          ),
                        ),

                        //Automatické sledovanie------------------------------------
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Automatické sledovanie',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(fontSize: 18),
                                ),
                              ),
                              Switch(
                                  value: Provider.of<Core>(context)
                                      .automatickeSledovanie,
                                  onChanged: (value) {
                                    setState(() {
                                      Provider.of<Core>(context, listen: false)
                                          .changeAutomatickeSledovanie();
                                    });
                                  })
                            ],
                          ),
                        ),
                        //-------------------------------------
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  'Biela mapa',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(fontSize: 18),
                                ),
                              ),
                              Switch(
                                  value: Provider.of<Core>(context).whiteMap,
                                  onChanged: (value) {
                                    setState(() {
                                      Provider.of<Core>(context, listen: false)
                                          .changeWhiteMap();
                                    });
                                  })
                            ],
                          ),
                        ),

                        //O Aplikácií-----------------------------------------------
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: TextButton(
                            child: Row(
                              children: [
                                Text(
                                  'O Aplikácií',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, TutorialTutorial.routeName);
                            },
                          ),
                        ),

                        //Bug report--------------------------------------------
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: TextButton(
                            child: Row(
                              children: [
                                Text(
                                  'Nahláste chybu',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              // ErrorAlert.showError(
                              //     context, 'Za vašu pomoc získavate 500 bodov',
                              //     title: 'Ďakujeme');
                              ErrorAlert.showBugReport(context);
                            },
                          ),
                        ),

                        //Odhlásenia------------------------------------------------
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: TextButton(
                            child: Row(
                              children: [
                                Text(
                                  'Odhlásenie',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(fontSize: 18),
                                ),
                              ],
                            ),
                            onPressed: () async {
                              await widget.stop();
                              FirebaseAuth.instance.signOut();
                            },
                          ),
                        ),

                        //Odísť-----------------------------------------------------
                        Container(
                          margin: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              TextButton(
                                child: Text(
                                  'Odísť',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(fontSize: 18),
                                ),
                                onPressed: () async {
                                  await widget.stop();
                                  Provider.of<DataFetcher>(context,
                                          listen: false)
                                      .updateUserData();
                                  Navigator.pushNamed(
                                      context, GoodbyePage.routeName);
                                  // exit(0);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    //Logo--------------------------------------------------------
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/images/Logo1.png',
                          height: 70,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
