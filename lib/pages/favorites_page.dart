import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteArticles;

  const FavoritesPage({Key? key, required this.favoriteArticles}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Artikel Favorit'),
        backgroundColor: Colors.deepPurple,
      ),
      body: favoriteArticles.isEmpty
          ? Center(
              child: Text(
                'Belum ada artikel favorit',
                style: TextStyle(fontSize: 18, color: Colors.deepPurple),
              ),
            )
          : ListView.builder(
              itemCount: favoriteArticles.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    final url = favoriteArticles[index]['url'];
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.favorite,
                          size: 40,
                          color: Colors.red,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            favoriteArticles[index]['title'],
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.deepPurple[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
