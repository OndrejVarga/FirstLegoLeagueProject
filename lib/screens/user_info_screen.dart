import 'package:FLL/providers/data_fetcher.dart';
import 'package:FLL/widgets/user_info_widget.dart';
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
    infos.add(UserInfoWidget('Farba', userData['color'].toString()));
    infos.add(UserInfoWidget('Obsah zabratého územia',
       '${userData['currAreaOfTerritory'].toInt().toString()} m*m'));
    infos.add(UserInfoWidget('Vzdialenosť','${userData['length'].toInt().toString()} m'));
    infos.add(UserInfoWidget('Počet bodov', userData['points'].toString()));
    infos.add(UserInfoWidget(
        'Počet prejdených krokov', userData['totalSteps'].toString()));
    infos.add(UserInfoWidget('Hmotnosť', '${userData['weight']} kg'.toString()));
     infos.add(UserInfoWidget('Spálené kalórie', '${userData['calories']} kcal'.toString()));

    return Scaffold(
       appBar: AppBar(
        title:const Text('Fll App'),
      ),
        backgroundColor: Theme.of(context).primaryColor,
          body: Center(
        child: SingleChildScrollView(
                  child: Column(
              children: [
                ...infos,
                FlatButton(child: Text("Späť"), onPressed:  () => Navigator.of(context).pop()),
              ],
            ),
        ),
        ),
    );
  }
}
