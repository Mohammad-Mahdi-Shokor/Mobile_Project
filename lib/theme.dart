import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // 🌙 DARK THEME
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,

    scaffoldBackgroundColor: const Color(0xFF1F1F39),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF3D5CFF),
      secondary: Color(0xFF18193C),
      surface: Color(0xFF161632),
      onSurface: Colors.white,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF3D5CFF),
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    ),

    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xFF1F1F39)),

    popupMenuTheme: PopupMenuThemeData(
      color: const Color(0xFF1F1F39),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: GoogleFonts.poppins(color: Colors.white),
    ),

    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    iconTheme: const IconThemeData(color: Colors.white),
  );

  // 🌞 LIGHT THEME
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,

    scaffoldBackgroundColor: const Color(0xFFF5F6FA),

    colorScheme: const ColorScheme.light(
      primary: Color(0xFF3D5CFF),
      secondary: Color(0xFFE6E7FF),
      surface: Colors.white,
      onSurface: Colors.black,
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0xFF3D5CFF),
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
    ),

    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),

    popupMenuTheme: PopupMenuThemeData(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: GoogleFonts.poppins(color: Colors.black),
    ),

    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
    iconTheme: const IconThemeData(color: Colors.black),
  );
}
