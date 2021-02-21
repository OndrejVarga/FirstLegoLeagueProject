import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/data_fetcher.dart';

class OwnedWidget extends StatefulWidget {
  @override
  _OwnedWidgetState createState() => _OwnedWidgetState();
}

class _OwnedWidgetState extends State<OwnedWidget> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> allColors =
        Provider.of<DataFetcher>(context).currUserInformation['ownedColors'];

    List<Widget> colorWidgets = allColors
        .map(
          (color) => InkWell(
            child: Container(
              child: color ==
                      Provider.of<DataFetcher>(context)
                          .currUserInformation['color']
                  ? Text('✔️',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 15))
                  : null,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Color(color), borderRadius: BorderRadius.circular(15)),
            ),
            onTap: () {
              setState(() {
                Provider.of<DataFetcher>(context, listen: false)
                    .changeUserColor(color);
              });
            },
          ),
        )
        .toList();

    return Container(
        child: GridView(
      primary: false,
      shrinkWrap: true,
      padding: const EdgeInsets.all(25),
      children: colorWidgets,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
    ));
  }
}
