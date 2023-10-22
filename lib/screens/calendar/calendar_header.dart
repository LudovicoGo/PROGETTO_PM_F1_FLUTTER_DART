import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalendarHeader extends StatefulWidget {
  final String heading;
  final Map<String, dynamic> calendarEvent;
  const CalendarHeader({Key? key, required this.heading, required this.calendarEvent}) : super(key: key);

  @override
  _CalendarHeaderState createState() => _CalendarHeaderState(calendarEvent);
}

class _CalendarHeaderState extends State<CalendarHeader> {
  final dynamic calendarEvent;

  _CalendarHeaderState(this.calendarEvent);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Card(
            color: Colors.white,
            child: Center(
              child: Container(
                height: 80.0,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                  "Calendar",
                  style: TextStyle(
                    fontFamily: 'formula1',
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Card(
            color: CupertinoColors.white,
            child: Center(
              child: SizedBox(
                height: 225.0,
                child: Column(
                  children: [
                    const Text(
                      "Next Event",
                      style: TextStyle(
                        fontFamily: 'formula1',
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
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
                                        calendarEvent['date'] != null ? convertDate(calendarEvent['date'].toString()) : "Data non disponibile",
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'formula1',
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                    Container(
                                      constraints: const BoxConstraints(maxWidth: 175.0),
                                      child: Text(
                                        calendarEvent['raceName'] != null ? calendarEvent['raceName'].toString() : "raceName non disponibile",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontFamily: 'formula1',
                                          fontWeight: FontWeight.bold,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                    Container(
                                      constraints: const BoxConstraints(maxWidth: 175.0),
                                      child: Text(
                                        calendarEvent['Circuit']['circuitName'] != null ? calendarEvent['Circuit']['circuitName'].toString() : "circuitName non disponibile",
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'formula1',
                                          fontWeight: FontWeight.w400,
                                        ),
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Container(
                              width: 170.0,
                              height: 130.0,
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String convertDate(String? inputDate) {
    if (inputDate != null) {
      final inputFormat = DateFormat("yyyy-MM-dd");
      final outputFormat = DateFormat("dd MMMM", 'it_IT');
      final date = inputFormat.parse(inputDate);
      final formattedDate = outputFormat.format(date);
      return formattedDate;
    } else {
      // Gestisci il caso in cui inputDate sia nullo
      return "Data non disponibile";
    }
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
