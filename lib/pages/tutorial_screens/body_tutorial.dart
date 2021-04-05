import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Body ',
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    .copyWith(fontSize: 30),
                textAlign: TextAlign.start,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                  'Za každé získané územie získavate  body. Za tieto body si  môžete kupovať farby pre vaše územia. Množstvo bodov získaných za územie je rovné obsahu získaného územia' +
                      ' Ak zaberiete územie inému uživateľovi získate k získaným bodom aj bonus.',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 20),
                  textAlign: TextAlign.start),
              Container(
                  //logo školy
                  margin: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/shop.gif',
                  )),
              Text('Váš počet bodov je porovnávaný s ostatnými uživateľmi',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontSize: 20),
                  textAlign: TextAlign.start),
              Container(
                  //logo školy
                  margin: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/table.PNG',
                    fit: BoxFit.cover,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
