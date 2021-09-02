import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData kDarkThemeData = ThemeData(
    scaffoldBackgroundColor: Color(0xFF2C2B41),
    primaryColor: Color(0xFF383856),
    accentColor: Color(0xFF5771FF),
    buttonColor: Color(0xFFFFFFFF),
    canvasColor: Color(0xFF383856),
    textTheme: _textTheme(Color(0xFFFFFFFF), Color(0xFF1E1F1E)),
    dividerColor: Color(0xFFEBEBEB),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
      GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.75, color: Color(0xFFEBEBEB)),
    ))),
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF2C2B41)),
    switchTheme: SwitchThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        thumbColor: MaterialStateProperty.all(Color(0xFFFFFFFF)),
        trackColor: MaterialStateProperty.all(Color(0xAAFFFFFF))),
    iconTheme: IconThemeData(color: Color(0xFFFFFFFF), size: 24));

TextTheme _textTheme(Color textColor, Color buttonColor) => TextTheme(
      headline1: GoogleFonts.roboto(fontSize: 97, fontWeight: FontWeight.w300, letterSpacing: -1.5, color: textColor),
      headline2: GoogleFonts.roboto(fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5, color: textColor),
      headline3: GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400, color: textColor),
      headline4: GoogleFonts.roboto(fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: textColor),
      headline5: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w500, color: textColor),
      headline6: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: textColor),
      subtitle1: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: textColor),
      subtitle2: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 1, color: textColor),
      bodyText1: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0.75, color: textColor),
      bodyText2: GoogleFonts.roboto(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.75, color: textColor),
      button: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: buttonColor),
      caption: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4, color: textColor),
      overline: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5, color: textColor),
    );
