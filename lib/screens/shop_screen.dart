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
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.center,
                  child: ShopDetails()),
              MainShopWidget()
            ],
          ),
        ),
      ),
    );
  }
}
