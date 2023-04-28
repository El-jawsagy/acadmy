import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:latlong2/latlong.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../map_page.dart';
import '../../styles/colors.dart';

class chooseBusCard extends StatelessWidget {
  final bool stime_am = true; // start time am,pm
  final String tripEnd; // End min
  final String tripStart; // End min
  final bool etime_am = true; // End time am,pm
  final String s_point;
  final String e_point;
  final String bus_no;
  final DocumentReference busRef;
  final double cost;
  final List<LatLng> latLngList;
  final List<String> stationNamesList;

  const chooseBusCard({
    required this.s_point,
    required this.e_point,
    required this.bus_no,
    required this.busRef,
    required this.cost,
    required this.tripEnd,
    required this.tripStart,
    required this.latLngList,
    required this.stationNamesList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: loginBlue,
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 10,
                spreadRadius: 0),
          ],
        ),
        child: MaterialButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MapPage(
                    latLngList: latLngList,
                    stationNamesList: stationNamesList,
                    busRef: busRef,
                  ),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$tripStart',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              ' am',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 10,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '$s_point',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$tripEnd',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Text(
                              ' pm',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.location_on,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              '$e_point',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.bus_alert_rounded,
                        color: Colors.yellowAccent,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$bus_no',
                        style: const TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 70,
                      ),
                      Text(
                        '$cost',
                        style: const TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'EGP',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
