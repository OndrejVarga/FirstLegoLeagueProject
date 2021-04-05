import 'package:flutter/material.dart';

class TerritoryTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Zaberanie územia',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 35),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Získavanie zahájite stlačnením tlačidla v strede navigácie \n' +
                    'Opätovným stlačením tlačidla sa zabraté územie priradí vám. \n' +
                    'Je dôležité aby zariadenie v čase ukončenia zaberania územia malo prístup na internet.',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(fontSize: 20),
                textAlign: TextAlign.start,
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Image.asset('assets/images/startStop.gif')),
              Text(
                ' Pri zaberaní územia je dôležité aby ste svojou trasou pretli už prejdenú časť trasy, tak ako je zobrazené na obrázku nižšie.' +
                    ' Územia môžete kradnúť aj ostatným hráčom, za čo získavate bonusy. Ak chcete zistiť komu územie patrí, stačí na ňho kliknúť',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(fontSize: 20),
                textAlign: TextAlign.start,
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Image.asset('assets/images/territory.gif')),
              Text(
                ' Ak chcete zistiť komu územie patrí, stačí na ňho kliknúť',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    .copyWith(fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
