import '../../providers/data_fetcher.dart';
import 'table_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: Provider.of<DataFetcher>(context).tableData.length,
      itemBuilder: (ctx, index) {
        return TableItem(
            index+1,
            Provider.of<DataFetcher>(context).tableData[index]['currAreaOfTerritory'],
            Provider.of<DataFetcher>(context).tableData[index]['username'],
            Provider.of<DataFetcher>(context).tableData[index]['UID']);
      },
    );
  }
}
