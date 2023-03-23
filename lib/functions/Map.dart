import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();

  void _onZoomInPressed() {
    _mapController.move(_mapController.center, _mapController.zoom + 1);
  }

  void _onZoomOutPressed() {
    _mapController.move(_mapController.center, _mapController.zoom - 1);
  }

  void _onCurrentLocationPressed() async {
    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    // Move the map to the current position
    _mapController.move(LatLng(position.latitude, position.longitude), 15.0);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          center: LatLng(30.0561,31.2394), // default center of the map
          zoom: 13.0, // default zoom level
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(30.0561, 31.2394),
                builder: (ctx) => Container(
                  child: SizedBox(),
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Color(0xFF040C4D),
            onPressed: _onZoomInPressed,
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Color(0xFF040C4D),
            onPressed: _onZoomOutPressed,
            child: Icon(Icons.remove),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            heroTag: null,
            backgroundColor: Color(0xFF040C4D),
            onPressed: _onCurrentLocationPressed,
            child: Icon(Icons.my_location),
          ),
        ],
      ),
    );
  }
}

