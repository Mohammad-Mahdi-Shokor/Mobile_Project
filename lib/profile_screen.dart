import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Achievement> achievements = [
    Achievement(Icon(Icons.school, color: Colors.blue), "Course 1"),
    Achievement(Icon(Icons.school, color: Colors.green), "Course 2"),
    Achievement(
      Icon(Icons.assignment_turned_in, color: Colors.orange),
      "Assign 1",
    ),
    Achievement(
      Icon(Icons.assignment_turned_in, color: Colors.deepOrange),
      "Assign 2",
    ),
    Achievement(Icon(Icons.emoji_events, color: Colors.amber), "Quiz 1"),
    Achievement(Icon(Icons.ondemand_video, color: Colors.redAccent), "Video 1"),
    Achievement(Icon(Icons.forum, color: Colors.purple), "Forum 1"),
    Achievement(Icon(Icons.star, color: Colors.yellow), "Skill 1"),
    Achievement(Icon(Icons.build, color: Colors.teal), "Project 1"),
    Achievement(
      Icon(Icons.local_fire_department, color: Colors.red),
      "Points 1",
    ),
    Achievement(Icon(Icons.whatshot, color: Colors.orangeAccent), "Streak 1"),
    Achievement(Icon(Icons.article, color: Colors.blueGrey), "Reader 1"),
  ];

  // yale fo2 sample achievements, menchelon later on :)
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        spacing: 15,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAqAMBIgACEQEDEQH/xAAaAAEAAgMBAAAAAAAAAAAAAAAABAcDBQYB/8QAORAAAgIBAgIHBwEGBwEAAAAAAAECBAMFEQZREiExQXGBsRMiQmGRodFyFiMyUmLBMzQ1c5Ky8BT/xAAWAQEBAQAAAAAAAAAAAAAAAAAAAQL/xAAWEQEBAQAAAAAAAAAAAAAAAAAAARH/2gAMAwEAAhEDEQA/ALSABpkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARdQv1tOrvNaydCPZFdrk+SRyOocXW809qUIYMfdJrpTf9ijt91zPSt1r+rKXS/+/L9jYUOL7mGSjdhDPj362l0Zfhg13AIun362o11mq5OlHsaa2cXyaJQAAEAAAAAAAAAAAAAAAAAwXbWKlVyWM8toY1u+b5IznIcdXm8mCjF+6l7WfovR/Uo57U9Qz6lblYzv9EN+qC5IiAFQAAEvS9Qz6bbjnrt8pQ36prkyyaVrFdq47OCW+Oa3XNc0/mVWdZwLdftM9Gbbjt7SCfkmvuhVdeADIAAAAAAAAAAAAAAAAeBXfFc3LXrO/wAPRS/4osQrzi3G4a9Yb+JRl9l+ClacAFQAAA23Ck3DXq23xdKL8HFmpNxwnjeTXsH9KlL7MCwwARQAEAAAAAAAAAAAAAAOP46ptZMF2KbTj7Kf1bXq/odgR79PFfp5Kudfu8i28H2p+TKKsBL1PTrGm2pYLMdn1uMu6a5oiFQAAA6vgSp+9sXZLqUfZR+qb9F9Tn9M0/PqdlYK8d3v78n2QXNlkUKeKhTx1sC2hjW3i+9/UipAAIAAAAAAAAAAAAAAAAAAKMNqrgt4Xis4oZIPuktzQWeDqk5OVazlw7/DLaa8u83tq9UqLe1ZxYuSlLrfl2mrzcV6VjbUJ5Mu38sPyBq/2Lyb/wCeht/tvf1Jdbg2pB9KzYy5f6I+4n/c9/bGhvsq9jbntH8mfDxXpeR7Slkxb984Pb7AbirWw1MSxVscceNd0fXx+ZlI9S9UuLerZxZV39GXWvLtJH/uoAACAAAAAAAAAAAAAAAGt1vV8Ok1unLaWafVjx79r5vkiiRqGoVtNw+1tZOgvhj2yk/kjjNU4pu224VZOrif8vXN+L/BqLtzPesysWZ9PI+/sS+SRgLiPZSc25Sbcn2tvrPAAAAA9i3GSlFuMl2ST2aN7pnFF2o1Cy3ZxcpP314Pv8zQgGrR0/UK2o4Pa1Mikl/FF9Uo+KJRVdK5no2I2KuRwyLq+TXJrvRYWh6vh1Wt04roZ4/4uPf+F818iK2QAAAAgAAAAAAAKMF21ipVclnM9oY1v48l5srTUb2XULmSzmfvSfUu6K7kjoON77nnx0MbfRgunk5OT7F9OvzOWKgAAAAAAAAAABJ027m0+5CzgfvR7Y90l3ojAC1KdrFdq47OF7wyR3XNc0zOcbwRfcc2Whkl7s4uePful3rzXodk+0igAIAAAAAAeNqKcpPaK62ekHW8rw6RcyJ7NYpbfQorm7YlbuZrMu3JNy8u77GAAqAAAAAAAAAAAAADPRsOpcwWI9uKaltz5/YtNNSSlF7xfWn8ipSzdEyvNo9PI+14o7+hKqcACAAAAAAGr4n/ANBt/pXqjwAVyADSAAAAAAAAAAAAAAWPwv16DU/Q/wDszwEqtqACAAAP/9k=",
            ),
          ),
          Text(
            'Mohammad Hammadi',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Software Engineer',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            '20, Male',
            style: GoogleFonts.spaceGrotesk(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: width * 0.85,
            height: height * 0.3,
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: achievements.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 25,
                  crossAxisSpacing: 25,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final Achievement a = achievements[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 4),
                        a.icon,
                        Wrap(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                a.name,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ],
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

class Achievement {
  final Icon icon;
  final String name;
  Achievement(this.icon, this.name);
}
