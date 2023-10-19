import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:f1_app_flutter/screens/calendar/calendar_events.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../calendar/calendar_header.dart';
import '../driver_standings/standings_drow_down_year_menu.dart';

class CalendarEventPage extends StatefulWidget {
  @override
  _CalendarEventPage createState() => _CalendarEventPage();
}

class _CalendarEventPage extends State<CalendarEventPage> {
  List<dynamic> calendarEvent = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData(2023);
  }


  int selectedItem = 0;

  Future<void> fetchData(int year) async {
    setState(() {
      isLoading = true;
      selectedItem = year;
    });
    final response = await http
        .get(Uri.parse('https://ergast.com/api/f1/$year.json'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final calendarEventData = data['MRData']['RaceTable']['Races'];

      setState(() {
        calendarEvent = calendarEventData;
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load the calendar');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black, Colors.black87,  Colors.grey],)),
            child: Stack(alignment: Alignment.bottomCenter, children: [
              ListView.builder(
                key: UniqueKey(),
                itemCount: calendarEvent.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0){
                    return const CalendarHeader(heading: 'Calendar');
                  } else {
                    return CalendarEventCard(calendarEvent: calendarEvent[index - 1]);
                  }
                },
              ),
              ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(9, 1, 4, 1),
                      width: 60,
                      height: 30,
                      color: Colors.black,
                      child: StandingsDropDownYearMenu(
                          selectedItem: selectedItem,
                          type: "events",
                          onYearChanged: (int newYear) {
                            //passo al widget del dropdown una funzione
                            setState(() {
                              fetchData(newYear).then((value) => setState(
                                      () {})); //quando seleziono un altro anno carico la classifica per il nuovo anno selezionato
                            });
                          }))),
              if (isLoading)
              // Mostra il ModalBarrier per bloccare le interazioni durante il caricamento
                Stack(alignment: Alignment.center, children: [
                  const ModalBarrier(
                    dismissible: false,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Container(
                          padding: const EdgeInsets.all(16),
                          color: Colors.white,
                          child: const Text(
                            'Loading...',
                            style: TextStyle(
                                fontFamily: 'formula1',
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          )))
                ]),
            ]),
          ),
        ),
      );
  }

}

void main() {
  runApp(MaterialApp(
    home: CalendarEventPage(),
  ));
}