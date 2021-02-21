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
      await Provider.of<DataFetcher>(context, listen: false).fetchInitData();
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
                FlatButton(
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
    return Scaffold(
      appBar: AppBar(
        title: Text(Provider.of<Core>(context, listen: false).pages[
                Provider.of<Core>(context, listen: false).selectedPageIndex]
            ['title']),
        actions: [
          PopupMenuButton(
            color: Theme.of(context).accentColor,
            itemBuilder: (_) => [
              PopupMenuItem(
                child: const Text('Automatické následovanie',
                    style: const TextStyle(color: Colors.white)),
                value: 1,
              ),
              PopupMenuItem(
                child: const Text('Len svoje územia',
                    style: const TextStyle(color: Colors.white)),
                value: 2,
              ),
              PopupMenuItem(
                child: const Text(
                  'Odhlásenie',
                  style: const TextStyle(color: Colors.white),
                ),
                value: 3,
              ),
              PopupMenuItem(
                child: const Text('Odísť',
                    style: const TextStyle(color: Colors.white)),
                value: 4,
              ),
            ],
            icon: const Icon(Icons.settings),
            onSelected: (selectedValue) async {
              setState(
                () {
                  if (selectedValue == 3) {
                    FirebaseAuth.instance.signOut();
                  } else if (selectedValue == 1) {
                    Provider.of<Core>(context, listen: false)
                        .changeAutomatickeSledovanie();
                  } else if (selectedValue == 2) {
                    Provider.of<Core>(context, listen: false)
                        .changeLenSvojeUzemie();
                  }
                },
              );
              bool isRunning = await FlutterForegroundServicePlugin
                  .isForegroundServiceRunning();

              if (selectedValue == 4) {
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
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
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
