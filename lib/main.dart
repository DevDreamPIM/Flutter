import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

import 'Screens/SplashScreen.dart';

void main() {
  runApp(
    CalendarControllerProvider(
      controller: EventController(), // Provide an EventController instance
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Epilepto Guard',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff00689B)),
          useMaterial3: true,
        ),
        home: SplashScreen());
  }
}
