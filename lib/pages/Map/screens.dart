import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MapScreen extends StatefulWidget {
  final List<LatLng> points;
  final List<String> names;


  MapScreen({required this.points, required this.names});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // final LatLng centerPoint = LatLng(13.0522, 80.2496);

  // final List<LatLng> points = [
  //   LatLng(12.9557, 80.2445), // Neelangarai
  //   LatLng(13.0860, 80.2101), // Anna Nagar
  //   LatLng(13.0500, 80.2824), // Marina Beach
  //   LatLng(12.9784, 80.2180), // Velachery
  // ];

  // final List<String> pointNames = [
  //   'Neelangarai',
  //   'Anna Nagar',
  //   'Marina Beach',
  //   'Velachery',
  // ];

  @override
  void initState() {
    super.initState();

    print("points");
    print(widget.points);
  }

  final Color centerColor = Colors.purple;
  final Color otherPointsColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.white,
         title: Text('Near By Hospital',style: TextStyle(fontSize: 35, fontWeight: FontWeight.w300)),),

      body: FlutterMap(
        options: MapOptions(
          initialCenter: widget.points[0],
          initialZoom: 13.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(
            markers: [
              // Marker(
              //   point: centerPoint,
              //   width: 80.0,
              //   height: 80.0,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         width: 80.0,
              //         padding: EdgeInsets.all(4.0),
              //         decoration: BoxDecoration(
              //           color:
              //               Colors.white.withOpacity(0.5), // Set opacity here
              //           borderRadius:
              //               BorderRadius.circular(8.0), // Curved borders
              //         ),
              //         child: Text(
              //           'Home',
              //           style: TextStyle(
              //               color: Color.fromARGB(255, 243, 3, 3),
              //               fontSize: 12,
              //               fontWeight: FontWeight.bold),
              //           textAlign: TextAlign.center,
              //           overflow: TextOverflow.ellipsis,
              //         ),
              //       ),
              //       Icon(
              //         MdiIcons.homeMapMarker,
              //         color: Colors.red[600],
              //         size: 40.0,
              //       ),
              //     ],
              //   ),
              // ),
              ...List.generate(widget.points.length, (index) {
                return Marker(
                  point: widget.points[index],
                  width: 80.0,
                  height: 80.0,
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => DetailPage(
                      //       point: widget.points[index],
                      //       name: widget.names[index],
                      //       center: widget.points[0],
                      //     ),
                      //   ),
                      // );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80.0,
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.5), // Set opacity here
                            borderRadius:
                            BorderRadius.circular(8.0), // Curved borders
                          ),
                          child: Text(
                            widget.names[index],
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Icon(
                          MdiIcons.doctor,
                          color: Colors.blue,
                          size: 40.0,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final LatLng point;
  final String name;
  final LatLng center;

  DetailPage({required this.point, required this.name, required this.center});

  @override
  Widget build(BuildContext context) {
    // Calculate distance using the original method
    final double meters = (center.latitude - point.latitude).abs() * 111.0 +
        (center.longitude - point.longitude).abs() * 111.0;
    final double kilometers = meters / 1000;

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Text(
          'Details of $name\nLatitude: ${point.latitude}\nLongitude: ${point.longitude}\nDistance from center: ${kilometers.toStringAsFixed(2)} km',
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
