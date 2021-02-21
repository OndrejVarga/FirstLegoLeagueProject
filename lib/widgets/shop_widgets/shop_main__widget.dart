import './buy_new_color_widget.dart';
import './owned_colors_widgets.dart';
import 'package:flutter/material.dart';

class MainShopWidget extends StatefulWidget {
  @override
  _MainShopWidgetState createState() => _MainShopWidgetState();
}

class _MainShopWidgetState extends State<MainShopWidget> {
  List<Widget> _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    _pages = [OwnedWidget(),BuyNewColorWidget()];
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(
                  child:const Text('Vlastnené'),
                  onPressed: () {
                    _selectPage(0);
                  },
                ),
                const SizedBox(
                  width: 30,
                ),
                FlatButton(
                  child:const Text('Nové'),
                  onPressed: () {
                    _selectPage(1);
                  },
                )
              ],
            ),
          ),
          Container(
            child: SingleChildScrollView(
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}
