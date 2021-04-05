import 'package:borderwander/pages/map_territory_page.dart';

import '../widgets/character_page_widgets/detail_part.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsTerritory extends StatelessWidget {
  static String routeName = 'detailsTerritory';
  final Map<String, dynamic> data;
  DetailsTerritory(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          shadowColor: Theme.of(context).backgroundColor,
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title-----------------------------------------------------------
              Container(
                child: Text(
                  'Dáta',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(fontSize: 30),
                ),
              ),
              //Content---------------------------------------------------------
              DetailPart('Obsah zabratého územia',
                  data['routeArea'].toInt().toString()),
              DetailPart('Prejdená vzdialenosť',
                  data['routeLength'].toInt().toString()),
              DetailPart(
                'Začiatok zaberania',
                DateFormat.jm()
                    .format(DateTime.parse(data['startTime'].toString())),
              ),
              DetailPart(
                  'Koniec zaberania',
                  DateFormat.jm()
                      .format(DateTime.parse(data['startTime'].toString()))),
              DetailPart('Trvanie', data['duration'].toString()),
              DetailPart(
                  'Spálené kalórie ', data['calories'].toInt().toString()),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) =>
                                MapTerritory(data['points'].toList())));
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pozrieť na mape',
                          style: Theme.of(context)
                              .textTheme
                              .headline3
                              .copyWith(fontSize: 20),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
