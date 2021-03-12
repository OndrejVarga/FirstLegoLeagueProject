import '../../providers/data_fetcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

class BuyNewColorWidget extends StatefulWidget {
  @override
  _BuyNewColorWidgetState createState() => _BuyNewColorWidgetState();
}

class _BuyNewColorWidgetState extends State<BuyNewColorWidget> {
  Color changedColor = Colors.black;

  void _buyColor() {
    Provider.of<DataFetcher>(context, listen: false).buyColor(changedColor);
  }

  void _donHaveMoney() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pozor"),
        content: const Text("Nemáš dostatok bodov!"),
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            color: Theme.of(context).accentColor,
            child: SlidePicker(
              sliderTextStyle: const TextStyle(color: Colors.white),
              indicatorBorderRadius: BorderRadius.circular(10),
              displayThumbColor: false,
              pickerColor: Theme.of(context).accentColor,
              paletteType: PaletteType.rgb,
              enableAlpha: false,
              showLabel: false,
              showIndicator: true,
              onColorChanged: (color) {
                changedColor = color;
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).accentColor,
            ),
            child: const Text(
              'Kúp si novú farbu za 1000!',
              style: const TextStyle(color: Colors.white),
            ),
            onPressed: Provider.of<DataFetcher>(context, listen: false)
                        .currUserInformation['points'] >
                    1000
                ? _buyColor
                : _donHaveMoney,
          ),
        ]),
      ),
    );
  }
}
