import 'package:flutter/material.dart';

class StandingsHeader extends StatefulWidget {
  final String heading;
  const StandingsHeader({Key? key, required this.heading}) : super(key: key);

  @override
  _StandingsHeaderState createState() => _StandingsHeaderState();
}

class _StandingsHeaderState extends State<StandingsHeader> {

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
                style: TextStyle(
                    fontFamily: 'formula1',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              )),
        ));
  }
}
