import 'package:cloud_firestore/cloud_firestore.dart';


class DataSender {
  static Future<void> sendToData(Map<String, dynamic> properties) async {
    await FirebaseFirestore.instance
        .collection('data')
        .doc(properties['timeOfEntryCreation'])
        .set({
      'UID': properties['UID'],
      'taken_territory': properties['taken_territory'],
    });
  }

  static Future<void> sendToTerritory(Map<String, dynamic> properties) async {
         await FirebaseFirestore.instance
        .collection('territory')
        .doc(properties['UID'])
        .collection('polygons')
        .doc(properties['timeOfEntryCreation'])
        .set(
          properties
        );
      }
}

