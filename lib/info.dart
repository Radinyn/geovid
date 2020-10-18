import 'package:flutter/material.dart';
import 'langmanager.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {

  Map data = {};
  String lang = "EN";

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    lang = data['lang'];

    return Scaffold(
      appBar: AppBar(title: Text(LM.t[lang]['INFO'])),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Center(child: Image.network('https://i.imgur.com/fHAz2yA.png'))),
          Text(
              LM.t[lang]['US'],
              style: TextStyle(
                fontSize: 20,
              )
          ),
          SizedBox(height: 10),
          Text(
              LM.t[lang]['HH']
          ),
          SizedBox(height: 5),
          Text(
              LM.t[lang]['DATA']
          ),
          SizedBox(height: 5),
        ],
      )
    );
  }
}
