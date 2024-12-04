import 'package:flutter/material.dart';
import 'package:projek_mobile/screens/feedback_screen.dart';
import 'package:projek_mobile/screens/profile_screen.dart';

class NavigationBar extends StatelessWidget {
  final String username; // Tambahkan parameter username

  NavigationBar({required this.username}); // Tambahkan konstruktor untuk menerima username

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.feedback),
          label: 'Saran & Kesan',
        ),
      ],
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(username: username), // Kirim username
              ),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FeedbackScreen(username: username), // Kirim username
              ),
            );
            break;
        }
      },
    );
  }
}