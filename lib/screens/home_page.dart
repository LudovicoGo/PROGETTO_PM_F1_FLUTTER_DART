import 'package:f1_app_flutter/screens/widgets/custom_bottom_navigation_bar.dart';
import 'package:f1_app_flutter/screens/widgets/driver_standings_widget.dart';
import 'package:f1_app_flutter/screens/teams_standings/teams_standings_page.dart';
import 'package:f1_app_flutter/screens/widgets/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppHomePage extends StatefulWidget {
  @override
  State<AppHomePage> createState() => _AppHomePage();
}

class _AppHomePage extends State<AppHomePage> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey,
        /* appBar: AppBar(
     title: Text("F1 APP"),),*/
        body: <Widget>[
          CalendarEventPage(),
          DriverStandingsPage(),
          TeamsStandingsPage(),
        ][currentIndex],
        bottomNavigationBar: Container(

            child: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              child: CustomBottomNavigationBar(
                  currentIndex: currentIndex,
                  onItemSelected: (int index) {
                    setState(() {
                      currentIndex = index;
                    });
                  })),
        )));
  }
/* NavigationBar(


                // height: 80,
                backgroundColor: Colors.black,
                onDestinationSelected: (int index){
                  setState((){
                    currentIndex = index;
                  });
                },
                // elevation: 50,

                indicatorColor: Colors.grey.withOpacity(.2),

                selectedIndex: currentIndex,
                destinations: [
                  NavigationDestination(
                      icon: Image.asset('assets/images/icons/flag_icon.png',
                        width: 30,
                        height: 30,
                        color: Colors.white, // Colore dell'icona
                        ), label: 'Calendar'),
                  NavigationDestination(
                      icon: Image.asset('assets/images/icons/helmet_icon.png',
                        width: 30,
                        height: 30,
                        color: Colors.white, // Colore dell'icona
                       ), label: 'Drivers'),
                  // NavigationDestination(icon: Icon(Image.Asset('assets/images/icons/helmet_icon.png'), color: Colors.white), label: 'Drivers'),
                  NavigationDestination(
                      icon: Image.asset('assets/images/icons/car_icon.png',
                        width: 30,
                        height: 30,
                        color: Colors.white
                       ), label: 'Teams'),
                ],

              )*/
}
