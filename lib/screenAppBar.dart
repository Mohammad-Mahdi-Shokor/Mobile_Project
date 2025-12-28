import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/data.dart';

AppBar ScreenAppBar(int index) {
  if (index != 0) {
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: 100,
      title: Text(
        'Profile',
        style: GoogleFonts.poppins(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          onPressed: () {},
          child: const Text(
            "Edit",
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ],
    );
  }

  return AppBar(
    backgroundColor: const Color(0xFF3D5CFF),
    toolbarHeight: 100,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hi, ${sampleUser.FirstName}',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          "Let's start learning",
          style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(sampleUser.profilePicture),
        ),
      ),
    ],
  );
}
