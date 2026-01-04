import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';

import '../services/user_preferences_services.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Achievement> achievements = sampleAchievements;
  final UserPreferencesService _userService = UserPreferencesService.instance;
  User? _currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    _currentUser = await _userService.getUser();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final displayUser = _currentUser ?? sampleUser;
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height + 40,
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // Profile avatar with border
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        isDark
                            ? const Color.fromRGBO(217, 217, 217, 100)
                            : const Color(0xFF3D5CFF),
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius: screenWidth * 0.15,
                  backgroundImage:
                      displayUser.profilePicture.startsWith('http')
                          ? NetworkImage(displayUser.profilePicture)
                          : FileImage(File(displayUser.profilePicture))
                              as ImageProvider,
                ),
              ),
              const SizedBox(height: 20),

              // Username
              Text(
                displayUser.username,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Tag/Profession
              Text(
                displayUser.tag,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.045,
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),

              // Age and Gender
              Text(
                "${displayUser.age}, ${displayUser.Gender}",
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.035,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              const SizedBox(height: 30),

              // Achievements section
              Text(
                'Achievements',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.05,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 15),

              // Achievements grid - responsive
              Container(
                width: double.infinity,
                constraints: BoxConstraints(maxHeight: screenHeight * 0.35),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.colorScheme.surface,
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: achievements.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final Achievement a = achievements[index];

                    return Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color:
                            isDark
                                ? theme.colorScheme.secondary.withOpacity(0.2)
                                : theme.colorScheme.secondary.withOpacity(0.3),
                        border: Border.all(
                          color: theme.colorScheme.outline.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconTheme(
                            data: IconThemeData(
                              size: screenWidth * 0.06,
                              color: theme.colorScheme.primary,
                            ),
                            child: a.icon,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            a.name,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: screenWidth * 0.025,
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
