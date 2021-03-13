import 'package:flutter/rendering.dart';

import '../providers/core.dart';
import '../providers/data_fetcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocation/geolocation.dart' as g;
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
  final List<LatLng> points;
  LatLng currUserLoc;
  final bool automatickeSledovanie;
  final bool lenSvojeUzemie;

  List<LatLng> userLocations = [];
  MapWidget(this.points, this.currUserLoc, this.automatickeSledovanie,
      this.lenSvojeUzemie);
}

class _MapWidgetState extends State<MapWidget> {
  StreamSubscription<g.LocationResult> subscription;
  MapController controller = MapController();
  double zoom = 18;
  bool init = false;

  Location location = Location();
  StreamSubscription<LocationData> locationSubscription;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (!init) {
      init = true;
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          controller.move(
              LatLng(widget.currUserLoc.latitude, widget.currUserLoc.longitude),
              18);
        },
      );
    }

    subscription = g.Geolocation.locationUpdates(
      accuracy: g.LocationAccuracy.best,
      displacementFilter: 5.0,
      inBackground: true,
    ).listen(
      (result) {
        if (result.isSuccessful) {
          if (widget.automatickeSledovanie &&
              context != null ) {
            controller.move(
                LatLng(result.location.latitude, result.location.longitude),
                18);
          } else {
            if (context != null) {
              controller.rotate(0);
            }
          }

          widget.userLocations.clear();

          widget.userLocations
              .add(LatLng(result.location.latitude, result.location.longitude));
          widget.currUserLoc =
              LatLng(result.location.latitude, result.location.longitude);

          if (!widget.points.contains(
              LatLng(result.location.latitude, result.location.longitude))) {
            widget.points.add(
                LatLng(result.location.latitude, result.location.longitude));
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('data').snapshots(),
      builder: (ctx, snapshot) => FlutterMap(
        mapController: controller,
        options: MapOptions(
          center:
              LatLng(widget.currUserLoc.latitude, widget.currUserLoc.longitude),
          zoom: 18,
          maxZoom: 18.0,
          minZoom: 2.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/ondrejvarga/ckgjqpqf71kjz19pebv6rky04/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoib25kcmVqdmFyZ2EiLCJhIjoiY2tnanB1b3BqMTBpaDMwdGU2bG45Ynp0diJ9.c9dh7GXc1C0rFKzuLO306Q',
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1Ijoib25kcmVqdmFyZ2EiLCJhIjoiY2tnanB1b3BqMTBpaDMwdGU2bG45Ynp0diJ9.c9dh7GXc1C0rFKzuLO306Q',
              'id': 'mapbox.streets',
            },
          ),
          PolygonLayerOptions(
            polygons: [
              ...Provider.of<DataFetcher>(context)
                  .getPolygonsFromSnapshot(snapshot.data),
              ...Provider.of<DataFetcher>(context).logInUserPolygons,
              if (!widget.lenSvojeUzemie)
                ...Provider.of<DataFetcher>(context).otherUsersPolygons,
            ],
            polygonCulling: true,
          ),
          PolylineLayerOptions(
            polylines: [
              Polyline(
                points: Provider.of<Core>(context, listen: false).isTakingLand
                    ? widget.points
                    : [],
                strokeWidth: 4.0,
                color: Color(Provider.of<DataFetcher>(context)
                    .currUserInformation['color']),
              ),
              Polyline(
                points: widget.userLocations,
                strokeWidth: 15.0,
                color: Color(Provider.of<DataFetcher>(context)
                    .currUserInformation['color']),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    if (locationSubscription != null) {
      locationSubscription.cancel();
    }
    if (subscription != null) {
      subscription.cancel();
    }
    super.dispose();
  }
}
