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
  displayLarge: GoogleFonts.montserrat(
      fontSize: 98, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.montserrat(
      fontSize: 61, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall: GoogleFonts.montserrat(fontSize: 49, fontWeight: FontWeight.w400),
  headlineMedium: GoogleFonts.montserrat(
      fontSize: 35, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400),
  titleLarge: GoogleFonts.montserrat(
      fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  titleMedium: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  titleSmall: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.montserrat(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.montserrat(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.montserrat(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.montserrat(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

const TextStyle textWhite = TextStyle(color: Colors.white);
const TextStyle textBlack = TextStyle(color: Colors.black);
const TextStyle textPrimary = TextStyle(color: primaryColor);

const TextStyle textBold = TextStyle(fontWeight: FontWeight.bold);

TextStyle textWhiteBold = textWhite.merge(textBold);
TextStyle textBlackBold = textBlack.merge(textBold);
