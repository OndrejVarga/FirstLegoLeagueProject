import 'package:flutter/material.dart';

class ShopDetailsInfo extends StatelessWidget {
  final String title;
  final String text;
  ShopDetailsInfo(this.title, this.text);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child:  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }
}
