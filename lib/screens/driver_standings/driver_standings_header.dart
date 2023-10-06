import 'package:f1_app_flutter/screens/driver_standings/standings_drow_down_year_menu.dart';
import 'package:flutter/material.dart';

class DriverStandingsHeader extends StatelessWidget {
  const DriverStandingsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        child: Center(
          child: Container(
              height: 80.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              child: const Text(
                "Drivers Standings",
                style: TextStyle(
                    fontFamily: 'formula1',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              )),
        ));
  }
}
