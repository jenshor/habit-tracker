import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:habit_tracker/constants/constant_colors.dart';
import 'pages/start_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: ConstantColors.green,
          accentColor: ConstantColors.green,
          textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black87),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            backgroundColor:
                MaterialStateProperty.all<Color>(ConstantColors.green),
            elevation: MaterialStateProperty.all<double>(0),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )),
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          appBarTheme: AppBarTheme(
            centerTitle: false,
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
