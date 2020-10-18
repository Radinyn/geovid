import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'geojson.dart';
import 'country.dart';
import 'langmanager.dart';

class GMap extends StatefulWidget {
  List<Country> Countries;
  String lang = 'EN';
  String mode = 'TCPM';

  GMap(n_Countries, n_lang, n_mode) {this.Countries = n_Countries; this.lang = n_lang; this.mode = n_mode;}
  @override
  _GMapState createState() => _GMapState();
}

class _GMapState extends State<GMap> {

  Set<Polygon> polygons = new Set();
  GoogleMapController mapController;
  double maximum;

  @override
  void initState()
  {
    super.initState();
  }

  Color getColor(ctr)
  {
    double cases = widget.mode == 'TCPM' ? ctr.tcpm : (widget.mode == 'TC' ? ctr.cases.toDouble() : ctr.new_cases.toDouble());
    int clr;
    double ratio = 100*(cases.toDouble()) / maximum;

    if (ratio < 9.9) {clr = 50;}
    else if (ratio < 19.9) {clr = 100;}
    else if (ratio < 29.9) {clr = 200;}
    else if (ratio < 39.9) {clr = 300;}
    else if (ratio < 49.9) {clr = 400;}
    else if (ratio < 59.9) {clr = 500;}
    else if (ratio < 69.9) {clr = 600;}
    else if (ratio < 79.9) {clr = 700;}
    else if (ratio < 89.9) {clr = 800;}
    else {clr = 900;}

    return Colors.lightBlue[clr];
  }

  Set<Polygon> getPolygons() {
    Set<Polygon> polygons = Set();

    for (Country ctr in widget.Countries) {
      bool is4 = false;

      // check if countries are split
      try {
        var a = GeoJson.c[ctr.iso][0][0][0][0];
        is4 = true;
      }
      catch (e){
        is4 = false;
      }

      // One bracket too much in the source file (!)

      if(GeoJson.c[ctr.iso] != null){
        if (!is4) {
          List<LatLng> points = [];
          for (int i = 0; i < GeoJson.c[ctr.iso][0].length; i++) {
            // GeoJson.c[ctr.iso][0][i][0] -> x
            // GeoJson.c[ctr.iso][0][i][1] -> y
            LatLng coord = LatLng(GeoJson.c[ctr.iso][0][i][1], GeoJson.c[ctr.iso][0][i][0]);
            points.add(coord);
          }

          polygons.add(
              Polygon(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) => AlertDialog(
                      content: Center(child: getCountryCircle(ctr)),
                      shape: CircleBorder(),
                    ),
                  );
                },
                polygonId: PolygonId( ctr.iso ),
                points: points,
                consumeTapEvents: true,
                strokeColor: Colors.grey,
                strokeWidth: 1,
                fillColor: getColor(ctr),
              )
          );

        }

        else {
          for (int i = 0; i < GeoJson.c[ctr.iso].length; i++) { // WHOLE COUNTRY
            List<LatLng> points = [];
            for (int j = 0; j < GeoJson.c[ctr.iso][i][0].length; j++) { // SPLIT PART
              // GeoJson.c[ctr.iso][i][0][j][0] -> x
              // GeoJson.c[ctr.iso][i][0][j][1] -> y
              LatLng coord = LatLng(GeoJson.c[ctr.iso][i][0][j][1], GeoJson.c[ctr.iso][i][0][j][0]);
              points.add(coord);
            }

            polygons.add(
                Polygon(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (_) => AlertDialog(
                        content: Center(child: getCountryCircle(ctr)),
                        shape: CircleBorder(),
                      ),
                    );
                  },
                  polygonId: PolygonId(ctr.iso + i.toString()),
                  points: points,
                  consumeTapEvents: true,
                  strokeColor: Colors.grey,
                  strokeWidth: 1,
                  fillColor: getColor(ctr),
                ));
          }
        }
      }
    }

    return polygons;
  }

  double getMax() {
    double maximum = -1;

    if (widget.mode == 'TCPM') {
      for (Country ctr in widget.Countries) {
        if (ctr.tcpm > maximum) {
          maximum = ctr.tcpm;
        }
      }
    }

    else if (widget.mode == 'TC') {
      for (Country ctr in widget.Countries) {
        if (ctr.cases > maximum) {
          maximum = ctr.cases.toDouble();
        }
      }
    }

    else {
      for (Country ctr in widget.Countries) {
        if (ctr.new_cases > maximum) {
          maximum = ctr.new_cases.toDouble();
        }
      }
    }

    return maximum;
  }

  Text getCountryCircle(Country ctr) => Text( //TODO IMPROVE
      (LM.t[widget.lang]['ISO'][ctr.iso] ?? ctr.iso) + "\n" +
      LM.t[widget.lang]['TC']  + ":\n" +
      ctr.cases.toString() + "\n" +
      LM.t[widget.lang]['TCPM'] + ":\n" +
      ctr.tcpm.toString() + "\n" +
      LM.t[widget.lang]['NC'] + ":\n" +
      ctr.new_cases.toString()
  );

  final LatLng _center = const LatLng(49.9684896, 20.4302983);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {

    maximum = getMax();
    polygons = getPolygons();

    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
      ),
      polygons: polygons,
    );
  }
}
