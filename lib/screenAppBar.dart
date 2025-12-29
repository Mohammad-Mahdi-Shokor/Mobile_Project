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
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.white70,
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: PopupMenuButton<String>(
          color: const Color(0xFF1F1F39),
          offset: const Offset(0, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          onSelected: (value) {},
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'achievements',
              child: Row(
                children: const [
                  Icon(Icons.emoji_events, color: Color(0xFF3D5CFF)),
                  SizedBox(width: 10),
                  Text(
                    'Achievements',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'account',
              child: Row(
                children: const [
                  Icon(Icons.person, color: Color(0xFF3D5CFF)),
                  SizedBox(width: 10),
                  Text(
                    'Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'settings',
              child: Row(
                children: const [
                  Icon(Icons.settings, color: Color(0xFF3D5CFF)),
                  SizedBox(width: 10),
                  Text(
                    'Settings',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const PopupMenuDivider(height: 20),
            PopupMenuItem(
              value: 'logout',
              child: Row(
                children: const [
                  Icon(Icons.logout, color: Colors.redAccent),
                  SizedBox(width: 10),
                  Text(
                    'Log out',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ],
              ),
            ),
          ],
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(sampleUser.profilePicture),
          ),
        ),
      ),
    ],
  );
}
