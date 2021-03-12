import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class MyTheme {
  ThemeData theme;

  static ThemeData getTheme(BuildContext context) {
    return ThemeData(
      primaryColor: HexColor('#000a12'),
      accentColor: HexColor('#263238'),
      cardColor: HexColor('#2e7d32'),
      //Oválne buttony
      buttonTheme: ButtonTheme.of(context).copyWith(
        textTheme: ButtonTextTheme.primary,
        buttonColor: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
