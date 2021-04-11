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
                'Územie začnete zaberať stlačením tlačidla s ikonou play.\n' +
                    'Opätovným stlačením zaberanie ukončíte. \n' +
                    'Je dôležité, aby zariadenie v čase ukončenia zaberania územia malo prístup na internet.',
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
                'Na priradenie územia sa musia čiary pretnúť.\n' +
                    'Územia môžete kradnúť aj ostatným hráčom, za čo získavate viac bodov. Ak chcete zistiť, komu územie patrí, stačí naň kliknúť.',
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
              SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}
