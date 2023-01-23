import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//
// Color
//

const Color primaryColor = Color(0xff5d4037);
const Color primaryLightColor = Color(0xff8b6b61);
const Color primaryDarkColor = Color(0xff321911);
const Color primaryTextColor = Color(0xffFFFFFF);

const Color secondaryColor = Color(0xffd84315);
const Color secondaryLightColor = Color(0xffff7543);
const Color secondaryDarkColor = Color(0xff9f0000);
const Color secondaryTextColor = Color(0xff000000);

//
// Typography
//

final TextTheme textTheme = TextTheme(
  headline1: GoogleFonts.montserrat(
      fontSize: 98, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.montserrat(
      fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.montserrat(fontSize: 49, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.montserrat(
      fontSize: 35, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.montserrat(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.montserrat(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

const TextStyle textWhite = TextStyle(color: Colors.white);
const TextStyle textBlack = TextStyle(color: Colors.black);
const TextStyle textPrimary = TextStyle(color: primaryColor);

const TextStyle textBold = TextStyle(fontWeight: FontWeight.bold);

TextStyle textWhiteBold = textWhite.merge(textBold);
TextStyle textBlackBold = textBlack.merge(textBold);
