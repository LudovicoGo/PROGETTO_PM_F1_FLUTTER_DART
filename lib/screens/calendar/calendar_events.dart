import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CalendarEventCard extends StatefulWidget {
  final Map<String, dynamic> calendarEvent;

  const CalendarEventCard({Key? key, required this.calendarEvent}) : super(key: key);

  @override
  _CalendarEventCardState createState() => _CalendarEventCardState(calendarEvent);
}

class _CalendarEventCardState extends State<CalendarEventCard> {
  final dynamic calendarEvent;

  _CalendarEventCardState(this.calendarEvent);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170.0,
      child: Card(
        color: CupertinoColors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(11),
          child: Center(
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxWidth: 150.0),
                            child: Text(
                              convertDate(calendarEvent['date'].toString()),
                              style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'formula1',
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                              softWrap: true, // Per mettere il testo a capo
                            ),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 175.0),
                            child: Text(
                              calendarEvent['raceName'].toString(),
                              style: const TextStyle(
                                fontSize: 20,
                                fontFamily: 'formula1',
                                fontWeight: FontWeight.bold,
                              ),
                              softWrap: true, // Permette il testo a capo
                            ),
                          ),
                          Container(
                            constraints: const BoxConstraints(maxWidth: 175.0),
                            child: Text(
                              calendarEvent['Circuit']['circuitName'].toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'formula1',
                                fontWeight: FontWeight.w400,
                              ),
                              softWrap: true, // Permette il testo a capo
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                    width: 170.0, // Larghezza fissa
                    height: 130.0, // Altezza fissa
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: 'https://flagpedia.net/data/flags/w1160/${getCountryCode(calendarEvent['Circuit']['Location']['country'].toString())}.webp',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String convertDate(String inputDate) {
    final parts = inputDate.split('-'); // Divide la data in parti usando il separatore '-'
    final day = int.parse(parts[2]);
    final month = int.parse(parts[1]);

    final months = [
      'gennaio', 'febbraio', 'marzo',
      'aprile', 'maggio', 'giugno',
      'luglio', 'agosto', 'settembre',
      'ottobre', 'novembre', 'dicembre'
    ];

    final formattedDate = '$day ${months[month - 1]}';

    return formattedDate;
  }

  String? getCountryCode(String countryName) {
    final Map<String, String> countryNameToCodeMap = {
      "Australia": "au",
      "Austria": "at",
      "Azerbaijan": "az",
      "Bahrain": "bh",
      "Belgium": "be",
      "Brazil": "br",
      "Canada": "ca",
      "China": "cn",
      "France": "fr",
      "Germany": "de",
      "Hungary": "hu",
      "India": "in",
      "Italy": "it",
      "Japan": "jp",
      "Malaysia": "my",
      "Mexico": "mx",
      "Monaco": "mc",
      "Netherlands": "nl",
      "Portugal": "pt",
      "Russia": "ru",
      "Singapore": "sg",
      "South Africa": "za",
      "Saudi Arabia": "sa",
      "Spain": "es",
      "Sweden": "se",
      "Switzerland": "ch",
      "Turkey": "tr",
      "UAE": "ae",
      "United Arab Emirates": "ae",
      "United Kingdom": "gb",
      "UK": "gb",
      "United States": "us",
      "USA": "us",
      "Qatar": "qa",
      "Korea": "kr",
      "Argentina": "ar",
    };

    return countryNameToCodeMap[countryName];
  }
}
