import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: AppBar(
        backgroundColor: const Color(0xFF3D5CFF),
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: Text(
              'Account',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.lock, color: Colors.white),
            title: Text(
              'Privacy',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.white),
            title: Text(
              'Notifications',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode, color: Colors.white),
            title: Text(
              'Appearance',
              style: GoogleFonts.poppins(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
