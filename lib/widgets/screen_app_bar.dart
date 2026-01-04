// ignore_for_file: file_names

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile_project/models/data.dart';
import 'package:mobile_project/screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:mobile_project/services/profile_state.dart';

AppBar ScreenAppBar(
  BuildContext context,
  int index,
  VoidCallback onToggleTheme,
  
) {
  final profileState = Provider.of<ProfileState>(context);
  final user = profileState.currentUser ?? sampleUser;
  final theme = Theme.of(context);
  final colors = theme.colorScheme;

  if (index != 0) {
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: 100,
      title: Text(
        'Profile',
        style: theme.textTheme.titleLarge!.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (ctx) {
                  return UserProfileScreen(
                    isEditing: true,
                    onToggleTheme: onToggleTheme,
                  );
                },
              ),
            );
            // Instantly refresh from ProfileState
            profileState.refreshUser();
          },
          child: Text("Edit", style: theme.textTheme.titleMedium!),
        ),
      ],
    );
  }

  return AppBar(
    toolbarHeight: 100,
    iconTheme: const IconThemeData(color: Colors.white),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hi, ${user.FirstName}',
          style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        Text(
          "Let's start learning",
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ],
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 16),
        child: PopupMenuButton<String>(
          offset: const Offset(0, 55),
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 'achievements',
              child: Row(
                children: [
                  Icon(Icons.emoji_events, color: colors.primary),
                  const SizedBox(width: 10),
                  const Text('Achievements'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'mode',
              onTap: onToggleTheme,
              child: Row(
                children: [
                  Icon(Icons.brightness_6, color: colors.primary),
                  const SizedBox(width: 10),
                  const Text('Change Mode'),
                ],
              ),
            ),
            PopupMenuItem(
              value: 'account',
              child: Row(
                children: [
                  Icon(Icons.person, color: colors.primary),
                  const SizedBox(width: 10),
                  const Text('Account'),
                ],
              ),
            ),
            const PopupMenuDivider(),
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
            backgroundImage: _getProfileImage(user.profilePicture),
          ),
        ),
      ),
    ],
  );
}

// Helper function to handle both network and local images
ImageProvider _getProfileImage(String imagePath) {
  if (imagePath.startsWith('http')) {
    return NetworkImage(imagePath);
  } else if (imagePath.isNotEmpty) {
    return FileImage(File(imagePath));
  } else {
    // Default fallback image
    return const NetworkImage('https://cdn.wallpapersafari.com/95/19/uFaSYI.jpg');
  }
}