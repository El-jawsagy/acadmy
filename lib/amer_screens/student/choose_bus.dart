import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
                  tabs: [
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
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> routesSnapshot) {
    if (routesSnapshot.hasError) {
    return Text('Error: ${routesSnapshot.error}');
    }
    if (routesSnapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    }

    // Get the routeNo values from the routes collection
    List<String> routeNos = routesSnapshot.data!.docs.map((doc) => doc.reference.path).toList();

    return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('routes')
        .where('university', isEqualTo: uniName)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> routesSnapshot) {
    if (routesSnapshot.hasError) {
    return Text('Error: ${routesSnapshot.error}');
    }
    if (routesSnapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    }

    // Get the routeNo values from the routes collection
    List<DocumentReference> routeRefs = routesSnapshot.data!.docs.map((doc) => doc.reference).toList();

    return StreamBuilder<QuerySnapshot>(
    stream: FirebaseFirestore.instance
        .collection('trip')
        .where('routeNo', whereIn: routeRefs)
        .snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> tripsSnapshot) {
    if (tripsSnapshot.hasError) {
    return Text('Error: ${tripsSnapshot.error}');
    }
    if (tripsSnapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    }

    return ListView.builder(
    itemCount: tripsSnapshot.data!.docs.length,
    itemBuilder: (BuildContext context, int index) {
    DocumentSnapshot document = tripsSnapshot.data!.docs[index];
    String tripStart = document['tripTime'];
    String tripEnd = document['tripEnd'];
    DocumentReference busRef = document['bus'];

    return FutureBuilder<DocumentSnapshot>(
    future: busRef.get(),
    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> busSnapshot) {
    if (busSnapshot.hasError) {
    return Text('Error: ${busSnapshot.error}');
    }
    if (busSnapshot.connectionState == ConnectionState.waiting) {
    return CircularProgressIndicator();
    }
    String busNo = busSnapshot.data!['busID'];

    return chooseBusCard(
    tripStart: tripStart,
    tripEnd: tripEnd,
    s_point: "sPoint",
    e_point: "ePoint",
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
    );})));}}
