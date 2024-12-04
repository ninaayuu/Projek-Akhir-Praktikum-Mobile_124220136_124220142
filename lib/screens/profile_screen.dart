import 'package:flutter/material.dart';
import 'package:projek_mobile/screens/sekolah_list_screen.dart';
import 'package:projek_mobile/screens/feedback_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String username; // Tambahkan parameter username

  ProfileScreen({required this.username}); // Tambahkan konstruktor

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SekolahListScreen(username: widget.username), // Kirim username
          ),
        );
        break;
      case 1:
        break; // Tetap di halaman profil
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => FeedbackScreen(username: widget.username), // Kirim username
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.deepPurple.shade50,
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Foto pertama
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  image: DecorationImage(
                    image: AssetImage('assets/images/karina.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              SizedBox(height: 16),

              // Tabel pertama
              Card(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(
                      color: Colors.deepPurple.shade200,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                    children: [
                      _buildTableRow('Nama', 'Karina Innova'),
                      _buildTableRow('NIM', '124220136'),
                      _buildTableRow('Hobi', 'Jalan-jalan'),
                      _buildTableRow('Alamat Asal', 'Palembang'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Foto kedua
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade100,
                  image: DecorationImage(
                    image: AssetImage('assets/images/profile.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(60),
                ),
              ),
              SizedBox(height: 16),

              // Tabel kedua
              Card(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(
                      color: Colors.deepPurple.shade200,
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                    children: [
                      _buildTableRow('Nama', 'Naura Aina Zahra'),
                      _buildTableRow('NIM', '124220142'),
                      _buildTableRow('Hobi', 'Badminton, Jogging'),
                      _buildTableRow('Alamat Domisili', 'Jember, Jawa Timur'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      
    );
  }

  TableRow _buildTableRow(String title, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.deepPurple,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      ],
    );
  }
}