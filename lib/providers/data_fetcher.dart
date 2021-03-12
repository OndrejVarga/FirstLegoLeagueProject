import 'package:FLL/utils/territory_managment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/foundation.dart';
import 'package:latlong/latlong.dart';
import 'dart:core';

class DataFetcher with ChangeNotifier {
  List<Polygon> _logInUserPolygons = [];
  List<Polygon> _otherUsersPolygons = [];
  List<Map<String, String>> _tableData = [];
  Map<String, dynamic> _currUserInformation = {};
  Map<String, int> _userColors = {};
  Map<String, dynamic> _settings = {};

//Getters-------------------------------------------------------------------
  List<Polygon> get logInUserPolygons => _logInUserPolygons;
  List<Polygon> get otherUsersPolygons => _otherUsersPolygons;
  List<Map<String, String>> get tableData => _tableData;
  Map<String, dynamic> get currUserInformation => _currUserInformation;
  Map<String, dynamic> get settings => _settings;
//Retreaving data---------------------------------------------------------------

//Transforming data getting from firebase stream to usable formats
  List<Polygon> getPolygonsFromSnapshot(QuerySnapshot snapshot) {
    if (snapshot != null) {
      _logInUserPolygons.clear();
      _otherUsersPolygons.clear();

      for (int i = 0; i < snapshot.docs.length; i++) {
        if (snapshot.docs[i].data()['UID'] ==
            FirebaseAuth.instance.currentUser.uid) {
          _logInUserPolygons.add(
            Polygon(
                points: convertFromServerToLatLngPoints(
                    snapshot.docs[i].data()['taken_territory']),
                color: Color(_currUserInformation['color']).withOpacity(0.3),
                borderColor:
                    Color(_currUserInformation['color']).withOpacity(0.3),
                borderStrokeWidth: 2),
          );
        } else {
          var color = Colors.white.value;
          if (_userColors[snapshot.docs[i].data()['UID']] != null) {
            color = _userColors[snapshot.docs[i].data()['UID']];
          }
          _otherUsersPolygons.add(
            Polygon(
              points: convertFromServerToLatLngPoints(
                  snapshot.docs[i].data()['taken_territory']),
              color: Color(color).withOpacity(0.3),
            ),
          );
        }
      }
    }
    return [];
  }

  Future<bool> fetchInitData() async {
    await fetchUserInfo();
    await fetchTableData();
    await fetchColorOfOtherUser();
    await fetchSettings();
    return true;
  }

//Getting user information
  Future<void> fetchUserInfo() async {
    _currUserInformation.clear();

    var userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();

    _currUserInformation.addAll({
      'UID': userData.id,
      'color': userData['color'],
      'currAreaOfTerritory': userData['currAreaOfTerritory'],
      'length': userData['length'],
      'ownedColors': userData['ownedColors'].toList(),
      'points': userData['points'],
      'totalSteps': userData['totalSteps'],
      'username': userData['username'],
      'weight': userData['weight'],
      'tutorial': userData['tutorial'],
      'calories': userData['calories'],
      'index': 0
    });
    notifyListeners();
  }

  Future<void> fetchSettings() async {
    _settings.clear();
    var settingsData = await FirebaseFirestore.instance
        .collection('core')
        .doc('settings')
        .get();
    _settings.addAll({
      'maxSpeed': settingsData['maxSpeed'],
      'met': settingsData['met'],
    });
    notifyListeners();
  }

//Get other users color
  Future<void> fetchColorOfOtherUser() async {
    _userColors.clear();
    var data = await FirebaseFirestore.instance.collection('users').get();
    data.docs.forEach((element) {
      _userColors.addAll({element.id: element.get('color')});
    });
  }

//Getting data to fill table
  Future<void> fetchTableData() async {
    _tableData.clear();

    QuerySnapshot allData = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('currAreaOfTerritory', descending: true)
        .get();

    for (int i = 0; i < allData.docs.length; i++) {
      _tableData.add({
        'UID': allData.docs[i].id,
        'username': allData.docs[i].get('username'),
        'currAreaOfTerritory':
            allData.docs[i].get('currAreaOfTerritory').toInt().toString(),
      });
      if (allData.docs[i].id == _currUserInformation['UID']) {
        _currUserInformation['index'] = i;
      }
    }
    notifyListeners();
  }

  void updateUserData() {
    var forUpdate =
        TerritoryManagment.getUserTotalAreaLength(_logInUserPolygons);

    FirebaseFirestore.instance
        .collection('users')
        .doc(_currUserInformation['UID'])
        .update({
      'currAreaOfTerritory': forUpdate['totalArea'],
      'length': forUpdate['totalLength'],
    });
  }

  void updateNewUserData(int steps, int points, double calories) {
    _currUserInformation['totalSteps'] += steps;
    _currUserInformation['points'] += points;
    _currUserInformation['calories'] += calories;

    FirebaseFirestore.instance
        .collection('users')
        .doc(_currUserInformation['UID'])
        .update({
      'totalSteps': _currUserInformation['totalSteps'],
      'points': _currUserInformation['points'],
      'calories': _currUserInformation['calories']
    });
  }

//Shop data---------------------------------------------------------------------------

  void buyColor(Color color) {
    if (!_currUserInformation['ownedColors'].contains(color.value)) {
      currUserInformation['points'] = currUserInformation['points'] - 1000;
      currUserInformation['ownedColors'].add(color.value);

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update(
        {
          'points': currUserInformation['points'],
          'ownedColors': currUserInformation['ownedColors']
        },
      );
    }
    notifyListeners();
  }

  void changeUserColor(int color) {
    _currUserInformation['color'] = color;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({'color': color});
    notifyListeners();
  }

  bool checkValiability(String name) {
    for (int i = 0; i < _tableData.length; i++) {
      if (_tableData[i]['username'] == name) {
        return false;
      }
    }
    return true;
  }

//Utils function----------------------------------------------------------------------

  List<LatLng> convertFromServerToLatLngPoints(List<dynamic> points) {
    List<LatLng> polygonPoints = [];
    for (int i = 0; i + 1 < points.length; i += 2) {
      polygonPoints.add(LatLng(points[i], points[i + 1]));
    }
    return polygonPoints;
  }

//Find functions
  Future<Map<String, dynamic>> findUIDFromPoints(
      List<LatLng> polygonPoints) async {
    QuerySnapshot data =
        await FirebaseFirestore.instance.collection('data').get();
    for (int i = 0; i < data.docs.length; i++) {
      var currPolyPoints = data.docs[i].get('taken_territory');
      if (TerritoryManagment.isSameTerritory(
          convertFromServerToLatLngPoints(currPolyPoints), polygonPoints)) {
        return {
          'UID': data.docs[i]['UID'],
          'reference': data.docs[i].reference
        };
      }
    }
    return null;
  }

  Future<void> deleteFrom(DocumentReference reference) async {
    await FirebaseFirestore.instance
        .runTransaction((Transaction myTransaction) async {
      myTransaction.delete(reference);
    });
  }
}
