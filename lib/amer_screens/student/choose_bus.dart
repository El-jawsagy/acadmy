import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../error_screens/no_result_found.dart';
import '../../shared/components/student_app/choose_bus_card.dart';
import '../../shared/styles/colors.dart';

class ChooseBusScreen extends StatelessWidget {
  final String uniName;
  const ChooseBusScreen({Key? key, required this.uniName});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: Icon(
                Icons.arrow_back,
                color: loginBlue,
              ),
              title: Text(
                'Choose Your Bus',
                style: TextStyle(color: loginBlue),
              ),
              bottom: TabBar(
                  isScrollable: true,
                  labelColor: loginBlue,
                  unselectedLabelColor: dbasicGreyColor,
                  tabs: const [
                    Tab(
                      text: 'Today',
                    ),
                    Tab(
                      text: 'day 1',
                    ),
                    Tab(
                      text: 'day 2',
                    ),
                  ]),
            ),
            body: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('routes')
                          .where('university', isEqualTo: uniName)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> routesSnapshot) {
                        if (routesSnapshot.hasError) {
                          return Text('Error: ${routesSnapshot.error}');
                        }
                        if (routesSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        // Get the routeNo values from the routes collection
                        List<DocumentReference> routeRefs = routesSnapshot
                            .data!.docs
                            .map((doc) => doc.reference)
                            .toList();

                        try{
                          return StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('trip')
                                .where('routeNo', whereIn: routeRefs.isNotEmpty ? routeRefs : [null])
                                .snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> tripsSnapshot) {
                              if (tripsSnapshot.hasError) {
                                // Handle the error
                                if (tripsSnapshot.error.toString().contains('Failed assertion')) {
                                  // Handle the 'in' filter error specifically
                                  return const Text('Error: Empty list passed to "whereIn" query');
                                } else {
                                  return Text('Error: ${tripsSnapshot.error}');
                                }
                              }
                              if (tripsSnapshot.connectionState == ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }
                              if (tripsSnapshot.data == null || tripsSnapshot.data!.docs.isEmpty) {
                                return const Text(
                                    'No trips found for this university.' // Display a message when no trips are found
                                );
                              }

                              return ListView.builder(
                                itemCount: tripsSnapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DocumentSnapshot document = tripsSnapshot.data!.docs[index];
                                  String tripStart = document['tripTime'];
                                  String tripEnd = document['tripEnd'];
                                  DocumentReference busRef = document['bus'];

                                  // Retrieve the route document
                                  DocumentReference routeRef = document['routeNo'];
                                  return FutureBuilder<DocumentSnapshot>(
                                    future: routeRef.get(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<DocumentSnapshot> routeSnapshot) {
                                      if (routeSnapshot.hasError) {
                                        return Text('Error: ${routeSnapshot.error}');
                                      }
                                      if (routeSnapshot.connectionState == ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      }
                                      List<DocumentReference> stationRefs =
                                      routeSnapshot.data!['stationRefs'].cast<DocumentReference>();

                                      // Retrieve the bus document
                                      return FutureBuilder<DocumentSnapshot>(
                                        future: busRef.get(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot> busSnapshot) {
                                          if (busSnapshot.hasError) {
                                            return Text('Error: ${busSnapshot.error}');
                                          }
                                          if (busSnapshot.connectionState == ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          }
                                          String busNo = busSnapshot.data!['busID'];

                                          // Use the retrieved stationRefs to access station documents
                                          return FutureBuilder<List<DocumentSnapshot>>(
                                            future: Future.wait(
                                                stationRefs.map((stationRef) => stationRef.get())),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<List<DocumentSnapshot>> stationSnapshots) {
                                              if (stationSnapshots.hasError) {
                                                return Text('Error: ${stationSnapshots.error}');
                                              }
                                              if (stationSnapshots.connectionState == ConnectionState.waiting) {
                                                return const CircularProgressIndicator();
                                              }

                                              // Extract station names from station documents
                                              List<String> stationNames = stationSnapshots.data!
                                                  .map((stationSnapshot) => stationSnapshot['stationName'])
                                                  .cast<String>()
                                                  .toList();

                                              return chooseBusCard(
                                                tripStart: tripStart,
                                                tripEnd: tripEnd,
                                                s_point: stationNames.isNotEmpty ? stationNames.first : 'Unknown',
                                                e_point: stationNames.isNotEmpty ? stationNames.last : 'Unknown',
                                                bus_no: busNo,
                                                cost: 17,
                                              );
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        }catch(e){
                          print(e);
                          return NoResultFoundScreen();
                        }
                      })
                ));
  }
}
