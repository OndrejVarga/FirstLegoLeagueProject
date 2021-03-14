import '../providers/data_fetcher.dart';
import '../widgets/user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Widget> infos = [];
    Map<String, dynamic> userData =
        Provider.of<DataFetcher>(context,listen: false).currUserInformation;
    infos.add(UserInfoWidget('Meno', userData['username']));
    infos.add(UserInfoWidget('Poradie', (userData['index']+1).toString()));
    infos.add(UserInfoWidget('Obsah zabratého územia',
       '${userData["currAreaOfTerritory"].toInt().toString()} m²'));
    infos.add(UserInfoWidget('Vzdialenosť','${userData['length'].toInt().toString()} m'));
    infos.add(UserInfoWidget('Počet bodov', userData['points'].toString()));
    infos.add(UserInfoWidget('Hmotnosť', '${userData['weight']} kg'.toString()));
     infos.add(UserInfoWidget('Spálené kalórie', '${userData["calories"].toInt().toString()} kcal'));

    return Scaffold(
       appBar: AppBar(
        title:const Text('Junior App'),
      ),
        backgroundColor: Theme.of(context).primaryColor,
          body: Center(
        child: SingleChildScrollView(
                  child: Column(
              children: [
                ...infos,
                TextButton(child: Text("Späť", style: TextStyle(color: Colors.white)), onPressed:  () => Navigator.of(context).pop()),
              ],
            ),
        ),
        ),
    );
  }
}
