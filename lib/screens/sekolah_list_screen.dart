import 'package:flutter/material.dart';
import 'package:projek_mobile/models/sekolah.dart';
import 'package:projek_mobile/screens/sekolah_detail_screen.dart';
import 'package:projek_mobile/screens/profile_screen.dart';
import 'package:projek_mobile/screens/feedback_screen.dart';
import 'package:projek_mobile/services/sekolah_service.dart';

class SekolahListScreen extends StatefulWidget {
  @override
  _SekolahListScreenState createState() => _SekolahListScreenState();
}

class _SekolahListScreenState extends State<SekolahListScreen> {
  List<Sekolah> sekolahList = [];
  List<Sekolah> filteredSekolahList = [];
  int currentPage = 1;
  bool isLoading = false;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    fetchSekolah();
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
          preferredSize: Size.fromHeight(50),
          child: Padding(
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
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedbackScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}