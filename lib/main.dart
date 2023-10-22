import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'screens/home_page.dart';

void main() async {
  await initializeDateFormatting('it_IT', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F1 APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: DefaultTabController( length: 3,child: Scaffold()),
      debugShowCheckedModeBanner: true,
      home: AppHomePage(),
    );
  }
}
