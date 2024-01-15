import 'package:f1_app_flutter/screens/driver_standings/driver_standings_card.dart';
import 'package:f1_app_flutter/screens/driver_standings/standings_drow_down_year_menu.dart';
import 'package:f1_app_flutter/screens/widgets/standings_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverStandingsPage extends StatefulWidget {
  @override
  _DriverStandingsPageState createState() => _DriverStandingsPageState();
}

class _DriverStandingsPageState extends State<DriverStandingsPage> {
  List<dynamic> driverStandings = []; //nello stato del widget metto una lista di oggetti dynamic, quindi una lista che può contenere un qualsiasi tipo di oggetto
  bool isLoading = false;

  @override
  void initState() {
    super
        .initState(); //inizializzo lo stato del widget lanciando il metodo per ottenere la classifica dei piloti
    fetchData(DateTime.now().year); //all'avvio viene mostrata la classifica per l'anno corrente
  }

  int selectedItem = 0;

  Future<void> fetchData(int year) async {
    setState(() {
      isLoading = true;
      selectedItem = year;
    });
    final response = await http
        .get(Uri.parse('https://ergast.com/api/f1/$year/driverStandings.json'));

    if (response.statusCode == 200) {
      // verifica se lo stato della risposta http è 200 (cioè la richista http è stata eseguita con successo)

      final Map<String, dynamic> data = json.decode(response.body); //per convertire il body della risposta ottenuta, il json in pratica, in un oggetto di tipo map

      if (data['MRData']['StandingsTable']['StandingsLists'].length != 0) {
        final driverStandingsData = data['MRData']['StandingsTable']['StandingsLists'][0]['DriverStandings']; //qui estraggo l'oggetto MRData.StandingsTable.StandingsLists[0].DriverStandings
        setState(() {
          driverStandings =
              driverStandingsData; //salvo nello stato del widget l'oggetto driverStandings estratto prima dal body json
          // print('DRIVERSTANDINGS aggiornato: $driverStandings');
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Container(
              width: 200, // Imposta la larghezza desiderata
              child: Text(
                '$year data not yet available...',
                style: TextStyle(
                  fontFamily: 'formula1',

                  fontSize: 14, // Modifica la dimensione del testo
                  fontWeight: FontWeight.normal, // Modifica lo stile del testo
                  color: Colors.black, // Modifica il colore del testo
                ),
              ),
            ),
            backgroundColor: Colors.grey[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
        fetchData(year-1);
      }
    } else {
      throw Exception(
          'Failed to load driver standings'); //se la richiesta http non è stata eseguita con successo lancio un'eccezione
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              toolbarHeight: 0,
            ),
      // backgroundColor: Colors.grey,
      body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black, Colors.black87,  Colors.grey],)),
          child: Stack(alignment: Alignment.bottomCenter, children: [
            ListView.builder(
              key: UniqueKey(),
              itemCount: driverStandings.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return StandingsHeader(heading: 'Drivers Standings');
                }
                return DriverStandingsCard(
                    driverStandings: driverStandings[index - 1]);
              },
            ),
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Container(
                    padding: EdgeInsets.fromLTRB(9, 1, 4, 1) /*all(5.0)*/,
                    width: 60,
                    height: 30,
                    color: Colors.black,
                    child: StandingsDropDownYearMenu(
                        selectedItem: selectedItem,
                        type: "drivers",
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
                ModalBarrier(
                  //per mostrare una sorta di overlay durante il caricamento della nuova classifica
                  color: Colors.black.withOpacity(0.4),

                  dismissible: false,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                        padding: EdgeInsets.all(16) /*all(5.0)*/,
                        color: Colors.white,
                        // width: 150,
                        // height: 150,
                        child: Text(
                          'Loading...',
                          style: TextStyle(
                              fontFamily: 'formula1',
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )))
              ]),
          ])),
    ));
  }
}

void main() {
  runApp(MaterialApp(
    home: DriverStandingsPage(),
  ));
}
