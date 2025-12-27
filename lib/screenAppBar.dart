import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AppBar ScreenAppBar(int index) {
  return index == 0
      ? AppBar(
        backgroundColor: const Color(0xFF3D5CFF),
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {},
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hi, Mostafa',
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
            ),
          ),
        ],
      )
      : AppBar(
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
            child: Text(
              "Edit",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ],
      );
}
