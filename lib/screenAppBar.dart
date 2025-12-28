import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    iconTheme: const IconThemeData(
      color: Colors.white, // drawer icon color
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
          radius: 25,
          backgroundImage: NetworkImage(
            "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAJQAqAMBIgACEQEDEQH/xAAaAAEAAgMBAAAAAAAAAAAAAAAABAcDBQYB/8QAORAAAgIBAgIHBwEGBwEAAAAAAAECBAMFEQZREiExQXGBsRMiQmGRodFyFiMyUmLBMzQ1c5Ky8BT/xAAWAQEBAQAAAAAAAAAAAAAAAAAAAQL/xAAWEQEBAQAAAAAAAAAAAAAAAAAAARH/2gAMAwEAAhEDEQA/ALSABpkAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARdQv1tOrvNaydCPZFdrk+SRyOocXW809qUIYMfdJrpTf9ijt91zPSt1r+rKXS/+/L9jYUOL7mGSjdhDPj362l0Zfhg13AIun362o11mq5OlHsaa2cXyaJQAAEAAAAAAAAAAAAAAAAAwXbWKlVyWM8toY1u+b5IznIcdXm8mCjF+6l7WfovR/Uo57U9Qz6lblYzv9EN+qC5IiAFQAAEvS9Qz6bbjnrt8pQ36prkyyaVrFdq47OCW+Oa3XNc0/mVWdZwLdftM9Gbbjt7SCfkmvuhVdeADIAAAAAAAAAAAAAAAAeBXfFc3LXrO/wAPRS/4osQrzi3G4a9Yb+JRl9l+ClacAFQAAA23Ck3DXq23xdKL8HFmpNxwnjeTXsH9KlL7MCwwARQAEAAAAAAAAAAAAAAOP46ptZMF2KbTj7Kf1bXq/odgR79PFfp5Kudfu8i28H2p+TKKsBL1PTrGm2pYLMdn1uMu6a5oiFQAAA6vgSp+9sXZLqUfZR+qb9F9Tn9M0/PqdlYK8d3v78n2QXNlkUKeKhTx1sC2hjW3i+9/UipAAIAAAAAAAAAAAAAAAAAAKMNqrgt4Xis4oZIPuktzQWeDqk5OVazlw7/DLaa8u83tq9UqLe1ZxYuSlLrfl2mrzcV6VjbUJ5Mu38sPyBq/2Lyb/wCeht/tvf1Jdbg2pB9KzYy5f6I+4n/c9/bGhvsq9jbntH8mfDxXpeR7Slkxb984Pb7AbirWw1MSxVscceNd0fXx+ZlI9S9UuLerZxZV39GXWvLtJH/uoAACAAAAAAAAAAAAAAAGt1vV8Ok1unLaWafVjx79r5vkiiRqGoVtNw+1tZOgvhj2yk/kjjNU4pu224VZOrif8vXN+L/BqLtzPesysWZ9PI+/sS+SRgLiPZSc25Sbcn2tvrPAAAAA9i3GSlFuMl2ST2aN7pnFF2o1Cy3ZxcpP314Pv8zQgGrR0/UK2o4Pa1Mikl/FF9Uo+KJRVdK5no2I2KuRwyLq+TXJrvRYWh6vh1Wt04roZ4/4uPf+F818iK2QAAAAgAAAAAAAKMF21ipVclnM9oY1v48l5srTUb2XULmSzmfvSfUu6K7kjoON77nnx0MbfRgunk5OT7F9OvzOWKgAAAAAAAAAABJ027m0+5CzgfvR7Y90l3ojAC1KdrFdq47OF7wyR3XNc0zOcbwRfcc2Whkl7s4uePful3rzXodk+0igAIAAAAAAeNqKcpPaK62ekHW8rw6RcyJ7NYpbfQorm7YlbuZrMu3JNy8u77GAAqAAAAAAAAAAAAADPRsOpcwWI9uKaltz5/YtNNSSlF7xfWn8ipSzdEyvNo9PI+14o7+hKqcACAAAAAAGr4n/ANBt/pXqjwAVyADSAAAAAAAAAAAAAAWPwv16DU/Q/wDszwEqtqACAAAP/9k=",
          ),
        ),
      ),
    ],
  );
}
