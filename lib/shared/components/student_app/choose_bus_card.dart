import 'package:flutter/material.dart';

import '../../styles/colors.dart';

class chooseBusCard extends StatelessWidget {

  final bool stime_am = true; // start time am,pm
  final String tripEnd;  // End min
  final String tripStart;  // End min
  final bool etime_am = true; // End time am,pm
  final String s_point;
  final String e_point;
  final String bus_no;
  final double cost;


  const chooseBusCard({
    required this.s_point,
    required this.e_point,
    required this.bus_no,
    required this.cost, required this.tripEnd, required this.tripStart,
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
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2,2),
              blurRadius: 10,
              spreadRadius:0
            ),
          ],
        ),
        child: MaterialButton(
          onPressed: (){
            Navigator.pushNamedAndRemoveUntil(context, '/bookTrip', (route) => false);
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
                                '$tripStart' ,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                ' am',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                           // crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.white,
                                size: 10,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '$s_point',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                ),
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
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              Text(
                                ' pm',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 15,
                              ),
                              Text(
                                '$e_point',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center ,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.bus_alert_rounded,
                        color: Colors.yellowAccent,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '$bus_no',
                        style: TextStyle(
                            color: Colors.yellowAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(
                        width: 70,
                      ),
                      Text(
                        '$cost',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'EGP',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                        ),
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
