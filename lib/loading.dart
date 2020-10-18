import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'country.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void addCountry(k, v) { // TODO: MAYBE SET TO 0 if NULL?
    if (k.length == 3) {
      try {
        Country ctr = new Country(
            k.toString(),
            v["data"][v["data"].length - 1]['total_cases'].round(),
            v["data"][v["data"].length - 1]['total_cases_per_million'],
            v["data"][v["data"].length - 1]['new_cases'].round(),
        );
        Countries.add(ctr);
      }
      catch (e) {}
    }
  }

  List<Country> Countries = [];
  void getData() async {
    //data from the back of the array
   Response response = await get('https://raw.githubusercontent.com/owid/covid-19-data/master/public/data/owid-covid-data.json');
   Map data = jsonDecode(response.body);
   data.forEach(addCountry);
   Navigator.pushReplacementNamed(context, '/home', arguments: {'Countries': Countries });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SpinKitFoldingCube(color: Colors.white, size: 50),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(child: Image.network('https://i.imgur.com/AMK5RDF.png')),
            ),
            SpinKitFoldingCube(color: Colors.white, size: 50),
          ],
        )
      )
    );
  }
}
