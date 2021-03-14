import 'package:fll/providers/data_fetcher.dart';
import 'package:provider/provider.dart';

import '../widgets/shop_widgets/shop_details_widget.dart';
import '../widgets/shop_widgets/shop_main__widget.dart';
import 'package:flutter/material.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: FutureBuilder(
            future: Provider.of<DataFetcher>(context, listen: false)
                .fetchShopData(),
            builder: (context, snap) {
              if (snap.hasData) {
                return Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.center,
                        child: ShopDetails()),
                    MainShopWidget()
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
