import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projek_mobile/models/sekolah.dart';
import 'package:projek_mobile/pages/article_page.dart';
import 'package:projek_mobile/screens/education_cost_screen.dart';
import 'package:projek_mobile/screens/login_screen.dart';
import 'package:projek_mobile/screens/sekolah_detail_screen.dart';
import 'package:projek_mobile/screens/profile_screen.dart';
import 'package:projek_mobile/screens/feedback_screen.dart';
import 'package:projek_mobile/services/sekolah_service.dart';
import 'dart:async'; // Import untuk Timer

class SekolahListScreen extends StatefulWidget {
  final String username;

  SekolahListScreen({required this.username});

  @override
  _SekolahListScreenState createState() => _SekolahListScreenState();
}

class _SekolahListScreenState extends State<SekolahListScreen> {
  List<Sekolah> sekolahList = [];
  List<Sekolah> filteredSekolahList = [];
  int currentPage = 1;
  bool isLoading = false;
  String searchQuery = '';
  Timer? timer; // Timer untuk memperbarui waktu
  int _selectedIndex = 0; // Untuk menyimpan indeks item yang dipilih

  @override
  void initState() {
    super.initState();
    fetchSekolah();
    startRealTimeClock(); // Memulai jam real-time
  }

  @override
  void dispose() {
    timer?.cancel(); // Membatalkan timer saat widget dihapus
    super.dispose();
  }

  void startRealTimeClock() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {}); // Memperbarui state setiap detik
    });
  }

  Future<void> fetchSekolah() async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
    });

    try {
      final data = await SekolahService.getSekolah(page: currentPage, perPage: 20);
      setState(() {
        sekolahList.addAll(data);
        filteredSekolahList = sekolahList; // Initialize the filtered list
        currentPage++;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching sekolah: $e');
    }
  }

  void filterSekolah(String query) {
    setState(() {
      searchQuery = query;
      filteredSekolahList = sekolahList.where((sekolah) {
        final schoolName = sekolah.sekolah.toLowerCase();
        final address = sekolah.alamat_jalan.toLowerCase();
        return schoolName.contains(query.toLowerCase()) || address.contains(query.toLowerCase());
      }).toList();
    });
  }

  String getCurrentTime(String timezone) {
    DateTime now = DateTime.now().toUtc();
    Duration offset;

    switch (timezone) {
      case 'WIB':
        offset = Duration(hours: 7);
        break;
      case 'WITA':
        offset = Duration(hours: 8);
        break;
      case 'WIT':
        offset = Duration(hours: 9);
        break;
      case 'London':
        offset = Duration(hours: 0);
        break;
      default:
        offset = Duration(hours: 0);
    }

    DateTime adjustedTime = now.add(offset);
    return DateFormat.Hms().format(adjustedTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Sekolah di Indonesia',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(140),
          child: Column(
            children: [
              Text(
                'Hallo, ${widget.username}', // Displaying the username
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  onChanged: filterSekolah,
                  decoration: InputDecoration(
                    hintText: 'Cari sekolah...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                  ),
                ),
              ),
              // Display dynamic time for different zones
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTimeColumn('WIB', getCurrentTime('WIB')),
                    _buildTimeColumn('WITA', getCurrentTime('WITA')),
                    _buildTimeColumn('WIT', getCurrentTime('WIT')),
                    _buildTimeColumn('London', getCurrentTime('London')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple.shade50, Colors.deepPurple.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.pixels == notification.metrics.maxScrollExtent) {
              if (!isLoading) {
                fetchSekolah();
              }
              return true;
            }
            return false;
          },
          child: ListView.builder(
            itemCount: filteredSekolahList.length + (isLoading ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == filteredSekolahList.length && isLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                final sekolah = filteredSekolahList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SekolahDetailScreen(npsn: sekolah.npsn),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: Icon(Icons.school, color: Colors.white),
                      ),
                      title: Text(
                        sekolah.sekolah,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text(
                        sekolah.alamat_jalan,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Saran & Kesan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Artikel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Biaya Pendidikan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout), // Ikon Logout
            label: 'Logout',
          ),
        ],
        selectedItemColor: Colors.deepPurple, // Active color
        unselectedItemColor: Colors.grey, // Inactive color
        onTap: (index) {
          // Navigasi dan logika logout
          if (index == 5) { // Jika ikon Logout diklik
            _logout();
          } else {
            setState(() {
              _selectedIndex = index; // Mengupdate indeks yang dipilih
            });
            switch (index) {
              case 0:
                // Beranda
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen(username: widget.username)),
                );
                break;
              case 2:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FeedbackScreen(username: widget.username)),
                );
                break;
              case 3:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArticlesPage()),
                );
                break;
              case 4:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EducationCostScreen()),
                );
                break;
            }
          }
        },
      ),
    );
  }

  Widget _buildTimeColumn(String label, String time) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.white)),
        Text(time, style: TextStyle(color: Colors.white)),
      ],
    );
  }

  void _logout() {
  // Implement your logout logic here
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginScreen()), 
  );
 
}
}
