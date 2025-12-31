import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<String> settingsItems = [
      "Account",
      "Privacy",
      "Notifications",
      "Appearance",
    ];
    final itemIcon = [
      Icons.person,
      Icons.lock,
      Icons.notifications,
      Icons.dark_mode,
    ];
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: const Color(0xFF3D5CFF),
        iconTheme: IconThemeData(color: Colors.white),
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
          ...settingsItems.map((item) {
            return ListTile(
              leading: Icon(
                itemIcon[settingsItems.indexOf(item)],
                color: theme.textTheme.bodyLarge!.color!,
              ),
              title: Text(
                item,
                style: GoogleFonts.poppins(
                  color: theme.textTheme.bodyLarge!.color!,
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
