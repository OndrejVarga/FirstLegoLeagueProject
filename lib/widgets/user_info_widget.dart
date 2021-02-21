import 'package:flutter/material.dart';

class UserInfoWidget extends StatelessWidget {
  final String name;
  final String data;

  UserInfoWidget(this.name, this.data);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 1 / 2,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Text((name),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 1 / 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                data,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
