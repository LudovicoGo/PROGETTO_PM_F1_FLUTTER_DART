import 'package:flutter/material.dart';
import 'package:f1_app_flutter/colors/TeamsColors.dart';
import 'package:flutter/services.dart';



class DriverStandingsCard extends StatefulWidget {
  final Map<String, dynamic> driverStandings;

  const DriverStandingsCard({Key? key, required this.driverStandings})
      : super(key: key);

  @override
  _DriverStandingsCardState createState() => _DriverStandingsCardState(driverStandings);
}

class _DriverStandingsCardState extends State<DriverStandingsCard> {
  final dynamic driverStandings;

  _DriverStandingsCardState(this.driverStandings);

  final teamColors = TeamsColors();

  @override
  void initState() {
    super.initState();
    checkIfImageExists();
  }

  bool isImagePresent = false;

  void checkIfImageExists() async {
    try {
      final ByteData data = await rootBundle.load('assets/images/faces/' + driverStandings['Driver']['driverId'].toString() + '.png');
      if (data.buffer.asUint8List().isNotEmpty) {
        setState(() {
          isImagePresent = true;
        });
      }
    } catch (e) {
      // Il file "albon.png" non è presente nella cartella "assets/images"
      setState(() {
        isImagePresent = false;
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
                  color: teamColors.teamColors[driverStandings['Constructors'][0]['constructorId'].toString()] ?? Colors.grey, // Colore del bordo inferiore
                  width: 4.0, // Larghezza del bordo inferiore
                ))),
                child: Center(
                    child: Stack(alignment: Alignment.bottomRight, children: [
                  Container(
                      height: 120.0,
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(driverStandings['position'].toString() + '.',
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
                                  driverStandings['Driver']['givenName']
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'formula1',
                                    fontWeight: FontWeight.w400,
                                  )),
                              Text(
                                  driverStandings['Driver']['familyName']
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: 'formula1',
                                    fontWeight: FontWeight.w900,
                                  )),
                              Text(getDriverConstructor(),
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'formula1',
                                    fontStyle: FontStyle.italic,
                                  )),
                            ],
                          ),
                          const Spacer(flex: 10),

                          const Spacer(),
                          Text(driverStandings['points'].toString(),
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
                      )),
                  getDriverNumber(),
                  Positioned(
                    left: 210,
                    // child: Image.asset('assets/images/faces/' + driverStandings['Driver']['driverId'].toString() + '.png'),
                    child:  isImagePresent ? Image.asset('assets/images/faces/' + driverStandings['Driver']['driverId'].toString() + '.png', width: 130) : Image.asset('assets/images/faces/noDriverPic.png', width: 130), // Sostituisci con l'immagine di fallback desiderata.
                    // child:  Image.asset(getDriverFace(driverStandings[index - 1]['Driver']['driverId'].toString()),
                    width: 130,
                  ),
                ])))));
  }

  String getDriverConstructor() {
    String driverConstructors =
        driverStandings['Constructors'][0]['name'].toString();
    driverStandings['Constructors'].forEach((constructor) {
      if (constructor['name'] != driverConstructors) {
        driverConstructors += '-' + constructor['name'];
      }
    });
    return driverConstructors;
  }


  Widget getDriverNumber() {
    if (driverStandings['Driver']['permanentNumber'] != null) {
      return Positioned(
        right: 10,
        child: Text(driverStandings['Driver']['permanentNumber'].toString(),
            style: TextStyle(
              fontSize: 80,
              color: (teamColors.teamColors[driverStandings['Constructors'][0]['constructorId'].toString()] ?? Colors.black).withOpacity(.1),
              fontFamily: 'formula1',
              fontStyle: FontStyle.italic,
            )),
      );
    } else
      return Container();
  }
}
