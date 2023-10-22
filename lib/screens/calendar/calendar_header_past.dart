import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarHeaderPast extends StatefulWidget {
  final String heading;
  const CalendarHeaderPast({Key? key, required this.heading}) : super(key: key);

  @override
  _CalendarHeaderState createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends State<CalendarHeaderPast> {

  _CalendarHeaderState();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Card(
            color: Colors.white,
            child: Center(
              child: Container(
                height: 80.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "Calendar",
                  style: TextStyle(
                    fontFamily: 'formula1',
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
