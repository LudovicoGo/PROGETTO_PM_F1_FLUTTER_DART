import 'package:flutter/material.dart';

class StandingsDropDownYearMenu extends StatefulWidget {
  final int selectedItem;
  final ValueChanged<int> onYearChanged;
  final String type;
  const StandingsDropDownYearMenu({Key? key, required this.selectedItem, required this.onYearChanged, required this.type,}) : super(key: key);

  @override
  State<StandingsDropDownYearMenu> createState() => _StandingsDropDownYearMenuState();
}

class _StandingsDropDownYearMenuState extends State<StandingsDropDownYearMenu> {
  late int selectedYear;
  late List<int> yearsList;
  // List<int> yearsList = List.generate(DateTime.now().year - 1949, (index) => DateTime.now().year - index);//genera una lista di anni dal 1950 all'anno corrente

  @override
  void initState() {
    super.initState();
    selectedYear = widget.selectedItem;
    yearsList = List.generate(DateTime.now().year - (widget.type == "teams" ? 1957 : 1949), (index) => DateTime.now().year - index);//genera una lista di anni dal 1950 all'anno corrente

  }
  // int selectedYear = DateTime.now().year; //anno selezionato inizializzato a quello corrente


  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      style: TextStyle(fontFamily: 'formula1', color: Colors.white),
      dropdownColor: Colors.black,
      // isExpanded: true,
      borderRadius: BorderRadius.all(Radius.circular(16)),
      value: selectedYear,
      underline: Container(),
      icon: Container(),
      /*icon: const Icon(
        Icons.arrow_drop_down, //per rimuovere la freccetta
        color: Colors.transparent,
      ),*/
      elevation: 20,

      onChanged: (int? newValue) {
        setState(() {
          selectedYear = newValue ?? selectedYear;
          widget.onYearChanged.call(selectedYear);
        });
      },
      items: yearsList.map((int year) {
        return DropdownMenuItem<int>(
          value: year,
          child: Text(year.toString()),
        );
      }).toList(),
    );
  }
}