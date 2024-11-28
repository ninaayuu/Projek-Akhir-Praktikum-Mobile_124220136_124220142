import 'package:flutter/material.dart';
import 'package:projek_mobile/pages/article_page.dart';
import 'package:projek_mobile/pages/favorites_page.dart';
import 'package:projek_mobile/screens/camera_access_screen.dart';
import 'education_cost_screen.dart';
import 'school_time_zone_screen.dart';
import 'sekolah_list_screen.dart';

class HomeScreen extends StatelessWidget {
  final String username; // Parameter username untuk menerima email pengguna
  final List<Map<String, dynamic>> favoriteArticles = [];

  HomeScreen({required this.username}); // Konstruktor untuk menerima username

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu Utama',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.deepPurple.shade50,
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hallo, $username!', // Tampilkan email pengguna
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildMenuButton(
                    context,
                    'Biaya Pendidikan',
                    EducationCostScreen(),
                  ),
                  SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    'Zona Waktu Sekolah',
                    SchoolTimeZoneScreen(),
                  ),
                  SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    'Daftar Sekolah',
                    SekolahListScreen(),
                  ),
                  SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    'Berita',
                    ArticlesPage(),
                  ),
                  SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    'Favorite Berita',
                    FavoritesPage(favoriteArticles: favoriteArticles),
                  ),
                  SizedBox(height: 20),
                  _buildMenuButton(
                    context,
                    'Kamera Akses',
                    CameraAccessScreen(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String label, Widget screen) {
    return ElevatedButton(
      onPressed: () {
        // Menavigasi ke halaman yang sesuai
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 40.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        shadowColor: Colors.deepPurple.shade100,
        elevation: 5,
      ),
    );
  }
}
