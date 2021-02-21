import '../providers/data_fetcher.dart';
import '../widgets/table_widgets/table_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TableScreen extends StatefulWidget {
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  bool init = false;
  @override
  void didChangeDependencies() async {
    if (!init) {
      init = true;
      await Provider.of<DataFetcher>(context,listen: false).fetchTableData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(child: TableWidget()),
    );
  }
}
