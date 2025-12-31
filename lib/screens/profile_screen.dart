import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';
import 'package:mobile_project/widgets/theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Achievement> achievements = sampleAchievements;
  // yale fo2 sample achievements, menchelon later on :)
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return Center(
      child: Column(
        spacing: 15,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color:
                    theme.brightness == AppTheme.darkTheme.brightness
                        ? Color.fromRGBO(217, 217, 217, 100)
                        : Colors.black,
                width: 3,
              ),
            ),
            child: CircleAvatar(
              radius: 60,

              backgroundImage: NetworkImage(sampleUser.profilePicture),
            ),
          ),
          Text(
            sampleUser.username,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            sampleUser.tag,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "${sampleUser.age}, ${sampleUser.Gender}",
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: 310,
            height: height * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
              ),
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),

              child: GridView.builder(
                itemCount: achievements.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 7,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final Achievement a = achievements[index];

                  final theme = Theme.of(context);
                  final isDark = theme.brightness == Brightness.dark;

                  return Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.all(8),
                    decoration:
                        isDark
                            ? BoxDecoration(
                              border: Border.all(
                                width: 0.5,
                                color:
                                    theme.brightness ==
                                            AppTheme.darkTheme.brightness
                                        ? Color.fromRGBO(217, 217, 217, 100)
                                        : Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            )
                            : BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: theme.colorScheme.secondary.withOpacity(
                                isDark ? 0.15 : 1,
                              ),
                              border: Border.all(
                                width: 0.5,
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.5,
                                ),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      isDark
                                          ? Colors.black.withOpacity(0.6)
                                          : Colors.black.withOpacity(0.12),
                                  blurRadius: isDark ? 6 : 8,
                                  spreadRadius: 2,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 4),
                        a.icon,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Text(
                            a.name,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
