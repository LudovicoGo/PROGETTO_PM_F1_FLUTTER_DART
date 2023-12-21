import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavigationBar(
      {Key? key, required this.currentIndex, required this.onItemSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onItemSelected,

      backgroundColor: Colors.black,
      unselectedItemColor: Colors.white70,
      selectedItemColor: Colors.white,
      unselectedLabelStyle: TextStyle(fontFamily: 'formula1', fontWeight: FontWeight.w400),
      selectedLabelStyle: TextStyle(fontFamily: 'formula1', fontWeight: FontWeight.bold),
      showUnselectedLabels: true,


      items: [
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icons/flag_icon.png',
              width: currentIndex == 0 ? 30 : 24,
              height: currentIndex == 0 ? 30 : 24,
              color: currentIndex == 0 ? Colors.white : Colors.white70, // Colore dell'icona
            ),
            label: 'Calendar'),
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/icons/helmet_icon.png',
              width: currentIndex == 1 ? 30 : 24,
              height: currentIndex == 1 ? 30 : 24,
              color: currentIndex == 1 ? Colors.white : Colors.white70, // Colore dell'icona
            ),
            label: 'Drivers'),
        BottomNavigationBarItem(
            icon: Image.asset('assets/images/icons/car_icon.png',
              width: currentIndex == 2 ? 30 : 24,
              height: currentIndex == 2 ? 30 : 24,
              color: currentIndex == 2 ? Colors.white : Colors.white70
            ),
            label: 'Teams'),
      ],
    );
  }
}
