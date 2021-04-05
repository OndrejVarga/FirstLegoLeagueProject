import 'package:borderwander/pages/all_territory.dart';

import '../providers/data_fetcher.dart';
import '../widgets/character_page_widgets/detail_part.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailData extends StatelessWidget {
  static String routeName = 'details';
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
      body: FutureBuilder(
        future: Provider.of<DataFetcher>(context, listen: false)
            .fetchAllTerritoriesData(context),
        builder: (ctx, snaphshot) {
          if (snaphshot.hasData)
            return SingleChildScrollView(
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
                    DetailPart(
                        'Obsah zabratého územia',
                        Provider.of<DataFetcher>(context, listen: false)
                            .currUserInformation['currAreaOfTerritory']
                            .toInt()
                            .toString()),
                    DetailPart(
                        'Prejdená vzdialenosť',
                        Provider.of<DataFetcher>(context, listen: false)
                            .currUserInformation['length']
                            .toInt()
                            .toString()),
                    DetailPart(
                        'Počet bodov',
                        Provider.of<DataFetcher>(context, listen: false)
                            .currUserInformation['points']
                            .toInt()
                            .toString()),
                    DetailPart(
                        'Spálené kalórie',
                        Provider.of<DataFetcher>(context, listen: false)
                            .currUserInformation['calories']
                            .toInt()
                            .toString()),
                    DetailPart(
                        'Zaberanie územia bez prestávky',
                        Provider.of<DataFetcher>(context, listen: false)
                            .streak
                            .toString()),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AllTerritory.routeName);
                        },
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Všetky územia',
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
            );
          else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
