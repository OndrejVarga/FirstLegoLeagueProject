import '../providers/data_fetcher.dart';
import '../utils/territory_managment.dart';
import '../utils/data_sender.dart';
import '../screens/map_screen.dart';
import '../screens/shop_screen.dart';
import '../screens/table_screen.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mt;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Core with ChangeNotifier {
  final List<Map<String, dynamic>> _pages = [
    {'page': ShopScreen(), 'title': 'Obchod'},
    {'page': MapScreen(), 'title': 'Mapa'},
    {'page': TableScreen(), 'title': 'Tabuľka'},
  ];

  int _selectedPageIndex = 1;
  bool _isTakingLand = false;
  DateTime _startTime;
  DateTime _endTime;
  int _initialSteps;
  bool _automatickeSledovanie = false;
  bool _lenSvojeUzemie = false;

//Getters-------------------------------------------------------------------
  List<Map<String, dynamic>> get pages => _pages;
  int get selectedPageIndex => _selectedPageIndex;
  bool get isTakingLand => _isTakingLand;
  bool get automatickeSledovanie => _automatickeSledovanie;
  bool get lenSvojeUzemie => _lenSvojeUzemie;

//Main Function--------------------------------------------------------------
  Future<void> startStopTakingLand(
      List<LatLng> points, int steps, BuildContext context) async {
    if (_isTakingLand) {
      _endTime = DateTime.now();
      List<LatLng> _routePoints = points;

      var avgSpeed = (mt.SphericalUtil.computeLength(_routePoints
              .map((e) => mt.LatLng(e.latitude, e.longitude))
              .toList()) /
          _endTime.difference(_startTime).inSeconds);

      if (avgSpeed.round() >
          Provider.of<DataFetcher>(context, listen: false)
              .settings['maxSpeed']) {
        _showSpeedDialog(context);
      } else {
        List<LatLng> newTerritory =
            TerritoryManagment.validateNewTerritory(_routePoints);

        //Polygon is valid
        if (newTerritory != null && newTerritory.length > 0) {
          newTerritory.toSet().toList();
          List<LatLng> terr =
              await checkForOtherTerritories(newTerritory, context);
          if (terr.length > 0) {
            newTerritory = [...terr];
          }

          var properties = _routeProperties(
              newTerritory,
              Provider.of<DataFetcher>(context, listen: false)
                  .logInUserPolygons,
              _startTime,
              _endTime,
              steps,
              _initialSteps,
              context);

          DataSender.sendToData(properties);
          DataSender.sendToTerritory(properties);

          Provider.of<DataFetcher>(context, listen: false).updateNewUserData(
              properties['steps'],
              properties['routeArea'].round(),
              properties['calories']);
        }
      }
    } else {
      _startTime = DateTime.now();
      _initialSteps = steps;
    }
    _isTakingLand = !_isTakingLand;
    notifyListeners();
  }

//Utlis------------------------------------------------------------------------
  void changePage(int selectedValue) {
    _selectedPageIndex = selectedValue;
    notifyListeners();
  }

  Map<String, dynamic> _routeProperties(
      List<LatLng> routePoints,
      List<Polygon> userPolygons,
      DateTime startTime,
      DateTime endTime,
      int steps,
      int initialSteps,
      BuildContext context) {
    var areaProperties =
        TerritoryManagment.getNewTotalAreaLength(userPolygons, routePoints);
    return {
      'UID': Provider.of<DataFetcher>(context, listen: false)
          .currUserInformation['UID'],
      'timeOfEntryCreation': DateTime.now().toIso8601String(),
      'length': mt.SphericalUtil.computeLength(
          routePoints.map((e) => mt.LatLng(e.latitude, e.longitude)).toList()),
      'avgSpeed': (mt.SphericalUtil.computeLength(routePoints
              .map((e) => mt.LatLng(e.latitude, e.longitude))
              .toList()) /
          _endTime.difference(_startTime).inSeconds),
      'routeArea': areaProperties['routeArea'],
      'routeLength': areaProperties['routeLength'],
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'duration': endTime.difference(startTime).toString(),
      'steps': steps - initialSteps,
      'taken_territory': _convertRouteToList(routePoints),
      'calories':
          calculateCalories(context, endTime.difference(startTime).inSeconds)
    };
  }

  Future<List<LatLng>> checkForOtherTerritories(
      List<LatLng> routePoints, BuildContext context) async {
    List<Polygon> otherUsersPolygons =
        Provider.of<DataFetcher>(context, listen: false).otherUsersPolygons;

    List<List<LatLng>> allIntersectionWithOthersPolygons =
        TerritoryManagment.isIntersectingWithOtherPolygon(
            routePoints, otherUsersPolygons);

    for (int i = 0; i < allIntersectionWithOthersPolygons.length; i++) {
      List<LatLng> fixedIntersectionWith =
          TerritoryManagment.validateNewTerritoryOnOtherTerritory(
              [...allIntersectionWithOthersPolygons[i]], routePoints);
      Map<String, dynamic> doc =
          await Provider.of<DataFetcher>(context, listen: false)
              .findUIDFromPoints(allIntersectionWithOthersPolygons[i]);

      await Provider.of<DataFetcher>(context, listen: false)
          .deleteFrom(doc['reference']);
      if (fixedIntersectionWith.length > 0) {
        await DataSender.sendToData({
          'timeOfEntryCreation': DateTime.now().toIso8601String(),
          'UID': doc['UID'],
          'taken_territory': _convertRouteToList(fixedIntersectionWith)
        });
      }
    }
    return routePoints;
  }

  void _showSpeedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pozor"),
        content: Text(
            "Prekročil si maximálnu povolené rýchlosť(${Provider.of<DataFetcher>(context, listen: false).settings['maxSpeed']})!"),
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

  List<double> _convertRouteToList(List<LatLng> routePoints) {
    List<double> doubleRoutePoints = [];
    for (int i = 0; i < routePoints.length; i++) {
      doubleRoutePoints.add(routePoints[i].latitude);
      doubleRoutePoints.add(routePoints[i].longitude);
    }
    return doubleRoutePoints;
  }

  double calculateCalories(BuildContext context, int time) {
    return (((Provider.of<DataFetcher>(context, listen: false).settings['met'] *
                    Provider.of<DataFetcher>(context, listen: false)
                        .currUserInformation['weight']) /
                200) *
            time) /
        60;
  }

  void changeAutomatickeSledovanie() {
    _automatickeSledovanie = !_automatickeSledovanie;
    notifyListeners();
  }

  void changeLenSvojeUzemie() {
    _lenSvojeUzemie = !_lenSvojeUzemie;
    notifyListeners();
  }
}
