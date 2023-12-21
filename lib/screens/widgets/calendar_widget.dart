import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:f1_app_flutter/screens/calendar/calendar_events.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../calendar/calendar_header.dart';
import '../calendar/calendar_header_past.dart';
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
    fetchData(DateTime.now().year);
  }


  int selectedItem = 0;

  Future<void> fetchData(int year) async {
    setState(() {
      isLoading = true;
      selectedItem = year;
    });
    try {
      final response = await http.get(Uri.parse('https://ergast.com/api/f1/$year.json'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final calendarEventData = data['MRData']['RaceTable']['Races'];

        setState(() {
          calendarEvent = calendarEventData;
          isLoading = false;
        });
      } else {
        // Se la risposta non è 200 (OK), gestisci l'errore qui
        setState(() {
          calendarEvent = [];
          isLoading = false;
        });
      }
    } catch (e) {
      // Gestisci qualsiasi eccezione che potrebbe essere sollevata durante la chiamata
      setState(() {
        calendarEvent = [];
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            toolbarHeight: 0,
          ),
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
                  if (index == 0) {
                    if (calendarEvent.isNotEmpty) {
                      // Trova la prossima gara utilizzando la funzione findNextRace
                      final nextRace = findNextRace(calendarEvent);

                      final nextRaceDateStr = nextRace['date'];
                      final nextRaceDate = DateTime.tryParse(nextRaceDateStr ?? '');

                      if (nextRaceDate != null && nextRaceDate.isAfter(DateTime.now())) {
                        return CalendarHeader(
                          heading: 'Calendar',
                          calendarEvent: nextRace);
                        } else {
                          return const CalendarHeaderPast(heading: 'Calendar');
                      }
                    }
                  }
                  else if (calendarEvent != null && index - 1 < calendarEvent.length) {
                    final event = calendarEvent[index - 1];
                    if (event != null) {
                      return CalendarEventCard(calendarEvent: event);
                    }
                  }
                  // Gestione quando l'elemento della lista è nullo o non ci sono eventi
                  return SizedBox(); // o qualsiasi altro widget vuoto
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
                              fetchData(newYear).then((value) => setState((){}));
                            });
                          })
                  )
              ),
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

  Map<String, dynamic> findNextRace(List<dynamic> calendarEvent) {
    final now = DateTime.now();
    Map<String, dynamic>? nextRace;

    if (calendarEvent != null) {
      for (final race in calendarEvent) {
        final raceDateStr = race?['date'];
        final raceDate = DateTime.tryParse(raceDateStr ?? '');

        final circuitName = race?['Circuit']?['circuitName'];

        if (raceDate != null && circuitName != null) {
          if (raceDate.isAfter(now) && (nextRace == null || raceDate.isBefore(DateTime.parse(nextRace['date'] ?? '')))) {
            nextRace = race;
          }
        }
      }
    }

    return nextRace ?? {};
  }




  bool isCurrentYear(int year) {
    final currentYear = DateTime.now().year;
    return year == currentYear;
  }


}

void main() {
  runApp(MaterialApp(
    home: CalendarEventPage(),
  ));
}