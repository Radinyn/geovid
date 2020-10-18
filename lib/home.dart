import 'package:flutter/material.dart';
import 'gmap.dart';
import 'country.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String lang = 'EN';
  String mode = 'TCPM';
  Map data = {};
  List<Country> Countries = [];

  @override
  Widget build(BuildContext context) {

    data = data.isEmpty ? ModalRoute.of(context).settings.arguments : data;
    Countries = data['Countries'];

    return Scaffold(
      body: Container(
        color: Colors.lightBlue,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    color: Colors.lightBlue,
                    child: IconButton(
                      padding: const EdgeInsets.all(8.0),
                      color: Colors.white,
                      icon: Icon( Icons.map ),
                      onPressed: () async {
                        dynamic result = await Navigator.pushNamed(context, '/home/mode', arguments: {'lang': lang});
                        setState(() {
                          mode = result['mode'];
                        });
                      },
                    ),
                  ),
                  Material(
                    color: Colors.lightBlue,
                    child: IconButton(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.white,
                        icon: Icon( Icons.language ),
                        onPressed: () async {
                          dynamic result = await Navigator.pushNamed(context, '/home/lang');
                          setState(() {
                            lang = result['lang'];
                          });
                        },
                      ),
                  ),
                  Material(
                    color: Colors.lightBlue,
                    child: IconButton(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.white,
                        icon: Icon( Icons.menu_book ),
                        onPressed: () async {Navigator.pushNamed(context, '/home/book', arguments: {'lang': lang});},
                      ),
                  ),
                  Material(
                    color: Colors.lightBlue,
                    child: IconButton(
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.white,
                        icon: Icon( Icons.info ),
                        onPressed: () async {Navigator.pushNamed(context, '/home/info', arguments: {'lang': lang});},
                      ),
                  ),
                ],
              ),
              Expanded(child: GMap(Countries, lang, mode))
            ],
          ),
        ),
      ),
    );
  }
}
