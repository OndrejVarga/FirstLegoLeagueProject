import 'package:fll/screens/user_info_screen.dart';

import '../../providers/data_fetcher.dart';
import './shop_details_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShopDetails extends StatefulWidget {
  @override
  _ShopDetailsState createState() => _ShopDetailsState();
}

class _ShopDetailsState extends State<ShopDetails> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              Provider.of<DataFetcher>(context).currUserInformation['points'].toString(),
              style: const TextStyle(color: Colors.white, fontSize: 40),
            ),
            const SizedBox(
              height: 20,
            ),
            ShopDetailsInfo('Celkové poradie',(Provider.of<DataFetcher>(context).currUserInformation['index'] + 1).toString()),
            const SizedBox(
              height: 5,
            ),
            ShopDetailsInfo('Územie (m²)',Provider.of<DataFetcher>(context).currUserInformation['currAreaOfTerritory'].toInt().toString()),
            const SizedBox(
              height: 5,
            ),
            ShopDetailsInfo('Prešiel si (m)',Provider.of<DataFetcher>(context).currUserInformation['length'].toInt().toString()),
            const SizedBox(
              height: 15,
            ),
            TextButton(onPressed:  () => Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => UserInfo() )), child:Text("Zisti viac", style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }
}
