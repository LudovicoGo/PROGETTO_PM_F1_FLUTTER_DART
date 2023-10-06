import 'package:flutter/material.dart';
import 'package:f1_app_flutter/colors/TeamsColors.dart';
import 'package:flutter/services.dart';



class TeamStandingsCard extends StatefulWidget {
  final Map<String, dynamic> constructorStandings;

  const TeamStandingsCard({Key? key, required this.constructorStandings})
      : super(key: key);

  @override
  _TeamStandingsCardState createState() => _TeamStandingsCardState(constructorStandings);
}

class _TeamStandingsCardState extends State<TeamStandingsCard> {
  final dynamic constructorStandings;

  _TeamStandingsCardState(this.constructorStandings);

  final teamColors = TeamsColors();
  bool isImagePresent = false;

  @override
  void initState() {
    super.initState();
    checkIfImageExists();

  }


  void checkIfImageExists() async {
    try {
      final ByteData data = await rootBundle.load('assets/images/logos/' + constructorStandings['Constructor']['constructorId'].toString() + '_logo.png');
      if (data.buffer.asUint8List().isNotEmpty) {
        setState(() {
          isImagePresent = true;
          // print("TROVATA TROVATA TROVATA TROVATA TROVATA TROVATA TROVATA TROVATA TROVATA ");
        });
      }
    } catch (e) {
      setState(() {
        isImagePresent = false;
        // print("MISSING MISSING MISSING MISSING MISSING MISSING MISSING MISSING MISSING ");
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Card(
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(11),
                bottomRight: Radius.circular(11)),
            child: Container(
              // color: Colors.white,
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          color: teamColors.teamColors[constructorStandings['Constructor']['constructorId'].toString()] ?? Colors.grey, // Colore del bordo inferiore
                          width: 4.0, // Larghezza del bordo inferiore
                        ))),
                child: Center(
                    child: Stack(alignment: Alignment.centerRight,
                        children: [
                          Positioned(

                            // bottom: 0,
                            right: 50,
                            // width: 100,
                          child: Opacity(
                          opacity: 0.2,
                            child:  isImagePresent ? Image.asset('assets/images/logos/' + constructorStandings['Constructor']['constructorId'].toString() + '_logo.png', width: 130,) : Container(height: 130, width: 130,), // Sostituisci con l'immagine di fallback desiderata.

                        ),),
                      Container(
                          height: 80.0,
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(constructorStandings['position'].toString() + '.',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'formula1',
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                              const SizedBox(width: 25.0),
                              // Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      constructorStandings['Constructor']['name'].toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'formula1',
                                        fontWeight: FontWeight.w400,
                                      )),
                                ],
                              ),
                              const Spacer(flex: 10),
                              Text(constructorStandings['points'].toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'formula1',
                                      fontWeight: FontWeight.w900)),
                              const Text('pt',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'formula1',
                                      fontWeight: FontWeight.w400)),
                            ],
                          ))

                    ])))));
  }
}
