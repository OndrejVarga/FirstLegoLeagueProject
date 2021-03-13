import '../providers/data_fetcher.dart';
import 'package:provider/provider.dart';

import '../screens/auth_screen.dart';
import '../screens/navigation_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userShapshot) {
          if (userShapshot.hasData) {
            return FutureBuilder(
              future: Provider.of<DataFetcher>(context, listen: false)
                  .fetchInitData(),
              builder: (ctx, data) {
                if (data.hasData) {
                  return NavigationScreen();
                } else {
                  return CircularProgressIndicator();
                }
              },
            );
          } else {
            return AuthScreen();
            
          }
        },
      ),
    );
  }
}
