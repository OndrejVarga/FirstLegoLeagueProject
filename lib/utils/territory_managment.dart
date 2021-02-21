import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as mt;
import 'package:poly/poly.dart' as pl;
import 'package:poly_collisions/poly_collisions.dart' as pl;

class TerritoryManagment {
  static List<LatLng> validateNewTerritory(List<LatLng> routePoints) {
    for (int i = 0; i < routePoints.length; i++) {
      for (int j = routePoints.length - 1; j - 1 > i + 1; j--) {
        LatLng intersection = _getIntersection(routePoints[i],
            routePoints[i + 1], routePoints[j], routePoints[j - 1]);

        if (intersection != null) {
          routePoints.insert(j, intersection);
          routePoints.insert(i + 1, intersection);

          bool deleting = true;
          for (int k = 0; k < routePoints.length; k++) {
            if (routePoints[k] == intersection) {
              deleting = !deleting;
            }
            if (deleting) {
              routePoints.removeAt(k);
              k--;
            }
          }
          return routePoints;
        }
      }
    }
    return [];
  }

  static List<LatLng> validateNewTerritoryOnOtherTerritory(
      List<LatLng> otherTerritory, List<LatLng> routePoints) {
    List<pl.Point> routePointsInPoints =
        routePoints.map((e) => pl.Point(e.longitude, e.latitude)).toList();
    for (int i = 0; i < otherTerritory.length; i++) {
      if (pl.PolygonCollision.isPointInPolygon(routePointsInPoints,
          pl.Point(otherTerritory[i].longitude, otherTerritory[i].latitude))) {
        otherTerritory.removeAt(i);
        i--;
      }
    }
    return otherTerritory;
  }

  static List<LatLng> validateNewTerritoryOnOtherTerritoryWhenParemetes(
      List<LatLng> otherTerritory,
      List<LatLng> routePoints,
      List<LatLng> intersections) {
    List<pl.Point> routePointsInPoints =
        routePoints.map((e) => pl.Point(e.longitude, e.latitude)).toList();
    for (int i = 0; i < otherTerritory.length; i++) {
      if (intersections.contains(otherTerritory[i])) {}
      if (pl.PolygonCollision.isPointInPolygon(routePointsInPoints,
          pl.Point(otherTerritory[i].longitude, otherTerritory[i].latitude))) {
        if (!intersections.contains(otherTerritory[i])) {
          otherTerritory.removeAt(i);
          i--;
        }
      }
    }
    return otherTerritory;
  }

  static List<List<LatLng>> isIntersectingWithOtherPolygon(
      List<LatLng> routePoints, List<Polygon> otherUserPolygons) {
    List<List<LatLng>> allIntersectingWith = [];
    List<pl.Point> routePointsInPoints =
        routePoints.map((e) => pl.Point(e.longitude, e.latitude)).toList();
    for (int i = 0; i < otherUserPolygons.length; i++) {
      if (pl.PolygonCollision.doesOverlap(
          routePointsInPoints,
          otherUserPolygons[i]
              .points
              .map((e) => pl.Point(e.longitude, e.latitude))
              .toList())) {
        allIntersectingWith.add(otherUserPolygons[i].points);
      }
    }
    return allIntersectingWith;
  }

  static LatLng _getIntersection(LatLng p0, LatLng p1, LatLng p2, LatLng p3) {
    var a1 = p1.latitude - p0.latitude;
    var b1 = p0.longitude - p1.longitude;
    var c1 = a1 * p0.longitude + b1 * p0.latitude;

    var a2 = p3.latitude - p2.latitude;
    var b2 = p2.longitude - p3.longitude;
    var c2 = a2 * p2.longitude + b2 * p2.latitude;

    var denominator = a1 * b2 - a2 * b1;

    if (a1 == 0 || b1 == 0 || c1 == 0) {
      return null;
    }

    if (denominator == 0) {
      return null;
    } else {
      var x = (b2 * c1 - b1 * c2) / denominator;
      var y = (a1 * c2 - a2 * c1) / denominator;

      var rx0 = (x - p0.longitude) / (p1.longitude - p0.longitude);
      var ry0 = (y - p0.latitude) / (p1.latitude - p0.latitude);

      var rx1 = (x - p2.longitude) / (p3.longitude - p2.longitude);
      var ry1 = (y - p2.latitude) / (p3.latitude - p2.latitude);

      if (((rx0 >= 0 && rx0 <= 1) || (ry0 >= 0 && ry0 <= 1)) &&
          ((rx1 >= 0 && rx1 <= 1) || (ry1 >= 0 && ry1 <= 1))) {
        return LatLng(y, x);
      }
    }
    return null;
  }

//Utils-----------------------------------------------
  static Map<String, double> getNewTotalAreaLength(
      List<Polygon> userPolygons, List<LatLng> routePoints) {
    var properties = getUserTotalAreaLength(userPolygons);
    double routePointsArea = mt.SphericalUtil.computeArea(
            routePoints.map((e) => mt.LatLng(e.latitude, e.longitude)).toList())
        .toDouble();
    double routePointsLength = mt.SphericalUtil.computeLength(
            routePoints.map((e) => mt.LatLng(e.latitude, e.longitude)).toList())
        .toDouble();
    return {
      'totalArea': properties['totalArea'] + routePointsArea,
      'totalLength': properties['totalLength'] + routePointsLength,
      'routeArea': routePointsArea,
      'routeLength': routePointsLength
    };
  }

  static Map<String, double> getUserTotalAreaLength(
      List<Polygon> userPolygons) {
    double totalArea = 0;
    double totalLength = 0;
    for (int i = 0; i < userPolygons.length; i++) {
      var currentPol = userPolygons[i]
          .points
          .map((e) => mt.LatLng(e.latitude, e.longitude))
          .toList();
      totalArea += mt.SphericalUtil.computeArea(currentPol);
      totalLength += mt.SphericalUtil.computeLength(currentPol);
    }
    return {
      'totalArea': totalArea,
      'totalLength': totalLength,
    };
  }

  static bool isSameTerritory(List<LatLng> route1, List<LatLng> route2) {
    if (route1.length != route2.length) {
      return false;
    } else {
      for (int i = 0; i < route1.length; i++) {
        if (route1[i] != route2[i]) {
          return false;
        }
      }
      return true;
    }
  }
}
