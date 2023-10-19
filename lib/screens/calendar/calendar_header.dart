import 'package:flutter/material.dart';

class CalendarHeader extends StatefulWidget {
  final String heading;
  const CalendarHeader({Key? key, required this.heading}) : super(key: key);

  @override
  _CalendarHeaderState createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends State<CalendarHeader> {

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Center(
          child: Container(
              height: 80.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.heading,
                style: const TextStyle(
                    fontFamily: 'formula1',
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),
              )),
        ));
  }
}
