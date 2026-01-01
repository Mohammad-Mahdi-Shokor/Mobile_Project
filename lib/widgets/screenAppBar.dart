// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mobile_project/models/data.dart';

AppBar ScreenAppBar(
  BuildContext context,
  int index,
  VoidCallback onToggleTheme,
  String firstName,
) {
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
          onPressed: () {},
          child: Text("Edit", style: theme.textTheme.titleMedium!),
        ),
      ],
    );
  }

  return AppBar(
    toolbarHeight: 100,
    iconTheme: IconThemeData(color: Colors.white),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hi, $firstName',
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
          itemBuilder:
              (context) => [
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
            backgroundImage: NetworkImage(sampleUser.profilePicture),
          ),
        ),
      ),
    ],
  );
}
