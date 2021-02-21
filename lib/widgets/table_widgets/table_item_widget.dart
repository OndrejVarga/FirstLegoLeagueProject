import 'package:FLL/providers/data_fetcher.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableItem extends StatelessWidget {
  final int index;
  final String username;
  final String currArea;
  final String userUid;
  TableItem(this.index, this.currArea, this.username, this.userUid);

  @override
  Widget build(BuildContext context) {
    const Color col = Colors.white;
    return Container(
      color: Provider.of<DataFetcher>(context, listen: false)
                  .currUserInformation['UID'] ==
              userUid
          ? Theme.of(context).accentColor
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1 / 3,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Text(('#${index.toString()}'),
                  style: const TextStyle(
                      color: col, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1 / 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                username,
                style: const TextStyle(
                    color: col, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1 / 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(currArea.toString(),
                  style: const TextStyle(
                      color: col, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
