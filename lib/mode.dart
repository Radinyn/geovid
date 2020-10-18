import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'langmanager.dart';

class Mode extends StatefulWidget {

  @override
  _ModeState createState() => _ModeState();
}

class _ModeState extends State<Mode> {

  Map data = {};
  String lang = "EN";

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    lang = data['lang'];

    return Scaffold(
      appBar: AppBar(
        title: Text(LM.t[lang]['MODE']),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded( // TCPM
            child: FlatButton(
              child: Text(LM.t[lang]['TCPM'], style: TextStyle(color: Colors.white, fontSize: 30)),
              color: Colors.lightBlue,
              onPressed: () { Navigator.pop(context, {'mode':'TCPM'}); },
            ),
          ),
          Container(color: Colors.lightBlue , height: 10),
          Expanded( // TC
            child: FlatButton(
              child: Text(LM.t[lang]['TC'], style: TextStyle(color: Colors.white, fontSize: 30)),
              color: Colors.lightBlue,
              onPressed: () { Navigator.pop(context, {'mode':'TC'}); },
            ),
          ),
          Container(color: Colors.lightBlue , height: 10),
          Expanded( // NC
            child: FlatButton(
              child: Text(LM.t[lang]['NC'], style: TextStyle(color: Colors.white, fontSize: 30)),
              color: Colors.lightBlue,
              onPressed: () { Navigator.pop(context, {'mode':'NC'}); },
            ),
          ),
        ],
      )
    );
  }
}
