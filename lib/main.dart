import 'package:geolocation/geolocation.dart';

import './providers/core.dart';
import './screens/auth_screen.dart';
import './screens/main_screen.dart';
import './screens/tutorial_screens/tutorial.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_service_plugin/flutter_foreground_service_plugin.dart';
import 'package:hexcolor/hexcolor.dart' show HexColor;
import 'package:provider/provider.dart';
import 'package:flutter_foreground_plugin/flutter_foreground_plugin.dart';
import 'providers/data_fetcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final GeolocationResult result = await Geolocation.isLocationOperational();
  if (result.isSuccessful) {
  } else {
    await Geolocation.requestLocationPermission(
      permission: const LocationPermission(
        android: LocationPermissionAndroid.fine,
      ),
      openSettingsIfDenied: true,
    );
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
        if(!(await FlutterForegroundServicePlugin.isForegroundServiceRunning())){
          startForegroundService();
        }
  //   if (state == AppLifecycleState.paused) {
  //     startForegroundService();
  //   } else if (state == AppLifecycleState.resumed) {
  //     if (await FlutterForegroundServicePlugin.isForegroundServiceRunning()) {
  //       await FlutterForegroundServicePlugin.stopForegroundService();
  //     }
  //   }
   }

  void startForegroundService() async {
    await FlutterForegroundPlugin.setServiceMethodInterval(seconds: 5);
    await FlutterForegroundServicePlugin.startForegroundService(
      notificationContent: NotificationContent(
        iconName: 'ic_stat_add_location',
        titleText: 'FLL Aplikácia beží na pozadí',
        color: Colors.green,
        priority: NotificationPriority.high,
      ),
      notificationChannelContent: NotificationChannelContent(
        id: 'forgroud',
        nameText: 'not',
        descriptionText: 'notification',
      ),
      isStartOnBoot: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: DataFetcher()),
        ChangeNotifierProvider.value(value: Core())
      ],
      child: MaterialApp(
        title: 'FLL App',
        theme: ThemeData(
          primaryColor: HexColor('#000a12'),
          accentColor: HexColor('#263238'),
          cardColor: HexColor('#2e7d32'),
          buttonTheme: ButtonTheme.of(context).copyWith(
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
        routes: {
          AuthScreen.routeName: (ctx) => AuthScreen(),
          TutorialTutorial.routeName: (ctx) => TutorialTutorial()
        },
      ),
    );
  }

  @override
  void dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await FlutterForegroundServicePlugin.stopForegroundService();
    super.dispose();
  }
}
