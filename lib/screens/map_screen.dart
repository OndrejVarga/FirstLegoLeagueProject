import '../providers/core.dart';
import '../widgets/map_widget.dart';
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';
import 'dart:async';

class MapScreen extends StatefulWidget {
  MapScreen();

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  bool _isInit = true;
  bool _isFetched = false;
  List<LatLng> points = [];
  Stream<StepCount> _stepCountStream;
  int _steps = -1;
  LatLng currLoc = LatLng(0, 0);

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(_onError);
    if (!mounted) return;
  }

  void onStepCount(StepCount event) {
    if (context != null) {
      if (Provider.of<Core>(context, listen: false).selectedPageIndex == 1) {
        setState(() {
          _steps = event.steps;
        });
      }
    }
  }

  void _onError(error) => print("Flutter Pedometer Error: $error");

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      var location = await Location.instance.getLocation();
      currLoc = LatLng(location.latitude, location.longitude);
      if (Provider.of<Core>(context, listen: false).selectedPageIndex == 1)
        setState(() {
          _isFetched = true;
        });
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: !_isFetched
          ? Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Center(child: CircularProgressIndicator()),
            )
          : MapWidget(
              points,
              currLoc,
              Provider.of<Core>(context, listen: false).automatickeSledovanie,
              Provider.of<Core>(context, listen: false).lenSvojeUzemie),
      floatingActionButton: FloatingActionButton(
        child: Icon(Provider.of<Core>(context).isTakingLand
            ? Icons.pause
            : Icons.play_arrow),
        onPressed: () async {
          if (!Provider.of<Core>(context, listen: false).isTakingLand) {
            points.clear();
          }
          Provider.of<Core>(context, listen: false)
              .startStopTakingLand(points, _steps, this.context);
        },
      ),
    );
  }

  @override
  void dispose() {
    _stepCountStream.listen(onStepCount).cancel();
    super.dispose();
  }
}
