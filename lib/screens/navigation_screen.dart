import '../providers/core.dart';
import '../providers/data_fetcher.dart';
import '../screens/tutorial_screens/tutorial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_service_plugin/flutter_foreground_service_plugin.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  bool isInit = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!isInit) {
      isInit = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!Provider.of<DataFetcher>(context, listen: false)
            .currUserInformation['tutorial']) {
          Navigator.of(context).pushNamed(TutorialTutorial.routeName);
        }
      });
    }
  }

  void _selectPage(int index) {
    const List<String> error = ['tabuľku', 'obchod'];
    setState(
      () {
        if ((Provider.of<Core>(context, listen: false).isTakingLand &&
            index != 1)) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text("Pozor"),
              content: Text(
                  "Pri zaberaní územia si nemôžeš pozrieť ${error[index == 0 ? 1 : 0]}!"),
              actions: <Widget>[
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          );
        } else {
          Provider.of<DataFetcher>(context, listen: false).updateUserData();
          Provider.of<Core>(context, listen: false).changePage(index);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool _automatickeSledovanie =
        Provider.of<Core>(context).automatickeSledovanie;
    bool _lenSvojUzemie = Provider.of<Core>(context).lenSvojeUzemie;

    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<Core>(context, listen: false).pages[
                Provider.of<Core>(context, listen: false).selectedPageIndex]
            ['title']),
        actions: [
          PopupMenuButton(
            color: Theme.of(context).accentColor,
            itemBuilder: (_) => [
              CheckedPopupMenuItem(
                enabled: true,
                checked: _automatickeSledovanie,
                value: 1,
                child: new Text(
                  'Automaticke Sledovanie',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              CheckedPopupMenuItem(
                enabled: true,
                checked: _lenSvojUzemie,
                value: 2,
                child: new Text('Len Svoje Územia',
                    style: TextStyle(color: Colors.white)),
              ),
              CheckedPopupMenuItem(
                enabled: true,
                checked: false,
                value: 3,
                child: new Text('O aplikácii',
                    style: TextStyle(color: Colors.white)),
              ),
              CheckedPopupMenuItem(
                enabled: true,
                checked: false,
                value: 4,
                child: new Text('Odhlásenie',
                    style: TextStyle(color: Colors.white)),
              ),
              CheckedPopupMenuItem(
                enabled: true,
                checked: false,
                value: 5,
                child: new Text('Odísť', style: TextStyle(color: Colors.white)),
              ),
            ],
            icon: const Icon(Icons.settings),
            onSelected: (selectedValue) async {
              setState(
                () {
                  if (selectedValue == 4) {
                    FirebaseAuth.instance.signOut();
                  } else if (selectedValue == 1) {
                    Provider.of<Core>(context, listen: false)
                        .changeAutomatickeSledovanie();
                  } else if (selectedValue == 2) {
                    Provider.of<Core>(context, listen: false)
                        .changeLenSvojeUzemie();
                  } else if (selectedValue == 3) {
                    Navigator.of(context).pushNamed(TutorialTutorial.routeName);
                  }
                },
              );
              bool isRunning = await FlutterForegroundServicePlugin
                  .isForegroundServiceRunning();

              if (selectedValue == 5) {
                Provider.of<DataFetcher>(context, listen: false)
                    .updateUserData();
                if (isRunning) {
                  await FlutterForegroundServicePlugin.stopForegroundService();
                }
                exit(0);
              }
            },
          ),
        ],
      ),
      body: Provider.of<Core>(context)
          .pages[Provider.of<Core>(context).selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withAlpha(70),
        selectedItemColor: Colors.white,
        currentIndex: Provider.of<Core>(context).selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.shopping_basket),
              label: "Obchod"),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.map),
              label: "Mapa"),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.people),
              label: "Tabuľka"),
        ],
      ),
    );
  }
}
