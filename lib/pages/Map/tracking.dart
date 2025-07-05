
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:skinscan_ai/pages/Map/screens.dart';



class Tracking extends StatefulWidget {


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<Tracking> {
  final List<LatLng> points = [

    // LatLng(17.040652  ,  82.1996870),
    // LatLng(17.026290  , 82.134278),
    // LatLng(17.095790  , 82.197255),
    // LatLng(17.072867 ,82.141201),
    // LatLng(17.051681, 82.172878), //samarlakota
    LatLng(12.9557, 80.2445), // Neelangarai
    LatLng(13.0860, 80.2101), // Anna Nagar
    LatLng(13.0500, 80.2824), // Marina Beach
    LatLng(12.9784, 80.2180), // Velachery
    LatLng(13.0381, 80.2573),

  ];

  final List<String> pointNames = [
    'Neelangarai',
    'Anna Nagar',
    'Marina Beach',
    'Velachery',
    'Kavery Hospital'
  ];

  @override
  Widget build(BuildContext context) {
    return  MapScreen(
        points: points,
        names: pointNames,

    );
  }
}
