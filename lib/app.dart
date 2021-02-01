import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/start_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            elevation: 0,
            color: Colors.transparent,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          scaffoldBackgroundColor: Color(0xFFF2F1F5),
          textTheme: GoogleFonts.montserratTextTheme().apply(
              bodyColor: Colors.black,
              decorationColor: Colors.black,
              displayColor: Colors.black)),
      title: 'Counter App',
      home: StartPage(),
    );
  }
}
