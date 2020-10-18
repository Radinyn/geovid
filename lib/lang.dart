import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Lang extends StatefulWidget {
  @override
  _LangState createState() => _LangState();
}

class _LangState extends State<Lang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: FlatButton( //EN
              child: Image.network('https://i.imgur.com/wbc99kU.png'),
              color: Colors.lightBlue,
              onPressed: () { Navigator.pop(context, {'lang':'EN'}); },
            ),
          ),
          Container(color: Colors.lightBlue , height: 10),
          Expanded(
            child: FlatButton( //PL
              child: Image.network('https://i.imgur.com/4954VzU.png'),
              color: Colors.lightBlue,
              onPressed: () { Navigator.pop(context, {'lang':'PL'}); },
            ),
          ),
        ],
      )
    );
  }
}
