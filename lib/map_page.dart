import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';


const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);

class MapPage extends StatefulWidget {
  final List<LatLng> latLngList;
  const MapPage({required this.latLngList});
  // const MapPage({Key? key, required this.latLngList}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  //on below line we have set the camera position
  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(30.06930, 31.34411),
    zoom: 12,
  );

  final Set<Marker> _markers = {};
  final Set<Polyline> _polyline = {};

  // list of locations to display polylines

  int counter = 0; //عشان حازم ميزعلش
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // declared for loop for various locations
    for (int i = 0; i < widget.latLngList.length; i++) {
      counter++;
      _markers.add(
          // added markers
          Marker(
        markerId: MarkerId(i.toString()),
        position: widget.latLngList[i],
        infoWindow: InfoWindow(
            title: 'HOTEL',
            snippet: '5 Star Hotel',
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Trip info'),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Driver name: Hazem El Tiaaaaaar',
                            style: style1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Time to station: 08:00', style: style1),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Time to destination: 08:00', style: style1),
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Fare: ${(counter - i) * 2} EGP', style: style1),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.green,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {
                                      ////////////////////////////////////////////////////////////////////////////////////////////////////////////
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: const Text(
                                                  'REQUEST CONFIRMED SUCCEFULLY :( !!!!!!'),
                                              content: Row(
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      height: 50,
                                                      width: double.infinity,
                                                      decoration: const BoxDecoration(
                                                        color: Colors.green,
                                                      ),
                                                      child: MaterialButton(
                                                        onPressed: () {
                                                          // Navigator.of(context).push(
                                                          //     MaterialPageRoute(builder: (context) => DriverHomePage()));
                                                        },
                                                        child: const Center(
                                                          child: Text(
                                                            'OK',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: const Center(
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                  ),
                                  child: MaterialButton(
                                    onPressed: () {},
                                    child: const Center(
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  });
            }),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polyline.add(Polyline(
        polylineId: const PolylineId('1'),
        points: widget.latLngList,
        color: Colors.green,
      ));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Color(0xFF0F9D58),
      //   // title of app
      //   title: Text("Trip Stations"),
      // ),
      body: Container(
        child: SafeArea(
          child: GoogleMap(
            //given camera position
            initialCameraPosition: _kGoogle,
            // on below line we have given map type
            mapType: MapType.normal,
            // specified set of markers below
            markers: _markers,
            // on below line we have enabled location
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            // on below line we have enabled compass location
            compassEnabled: true,
            // on below line we have added polylines
            polylines: _polyline,
            // displayed google map
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);

              // Move camera to first marker
              controller.moveCamera(CameraUpdate.newLatLng(widget.latLngList[0]));
            },
          ),
        ),
      ),
    );
  }
}

TextStyle style1 = const TextStyle(fontSize: 20, color: Colors.black);
