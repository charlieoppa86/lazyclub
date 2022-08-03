import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const defaultPadding = 10.0;
const Color bluishClr = Color(0xFF055CF5);
const Color yelloishClr = Color(0xFFFFB746);
const Color darkBgClr = Color(0xFF1A1C1E);
const Color lightBgClr = Color(0xFFE9E9E9);
const Color headTextClr = Color(0xFF424242);
const Color subTextClr = Color(0xFF7A7A7A);

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        textTheme: GoogleFonts.getTextTheme("IBM Plex Sans KR"),
        /*  TextTheme(
                bodyText1: TextStyle(color: Colors.white),
                bodyText2: TextStyle(color: Colors.white))), */
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: isDarkTheme
            ? AppBarTheme(
                color: Colors.black,
                elevation: 0,
                centerTitle: false,
                actionsIconTheme: IconThemeData(color: Colors.white))
            : AppBarTheme(
                color: Colors.white,
                elevation: 0,
                centerTitle: false,
                actionsIconTheme: IconThemeData(color: Colors.black)),
        scaffoldBackgroundColor:
            isDarkTheme ? const Color(0xFF00001a) : const Color(0xFFFFFFFF),
        primaryColor: Colors.blue,
        colorScheme: ThemeData().colorScheme.copyWith(
              secondary: isDarkTheme
                  ? const Color(0xFF1a1f3c)
                  : const Color(0xFFE8FDFD),
              brightness: isDarkTheme ? Brightness.dark : Brightness.light,
            ),
        cardColor:
            isDarkTheme ? const Color(0xFF0a0d2c) : const Color(0xFFF2FDFD),
        canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: isDarkTheme
                ? const ColorScheme.dark()
                : const ColorScheme.light()));
  }
}
