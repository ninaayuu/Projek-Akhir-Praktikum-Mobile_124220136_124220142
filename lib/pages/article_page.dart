import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'favorites_page.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final List<Map<String, dynamic>> newsArticles = [
    {
      'title': 'Berita Dan Informasi Pendidikan Terkini Dan Terbaru Hari ini -Detikcom',
      'url': 'https://www.detik.com/tag/pendidikan',
      'isFavorite': false,
    },
    {
      'title': 'Berita Harian Pendidikan',
      'url': 'https://www.kompas.com/tag/pendidikan',
      'isFavorite': false,
    },
    {
      'title': 'Berita Pendidikan Hari Ini-Kabar Terbaru Terkini',
      'url': 'https://www.cnnindonesia.com/tag/pendidikan',
      'isFavorite': false,
    },
    {
      'title': 'Kumpulan Berita Pendidikan dan Terupadate',
      'url': 'https://kumparan.com/topic/pendidikan',
      'isFavorite': false,
    },
    {
      'title': 'Kumpulan Berita Pendidikan Di Indonesia',
      'url': 'https://www.suara.com/tag/pendidikan-di-indonesia',
      'isFavorite': false,
    },
  ];

  void _goToFavoritesPage() {
    List<Map<String, dynamic>> favoriteArticles = newsArticles
        .where((article) => article['isFavorite'])
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesPage(favoriteArticles: favoriteArticles),
      ),
    );
  }

  void toggleFavorite(int index) {
    setState(() {
      newsArticles[index]['isFavorite'] = !newsArticles[index]['isFavorite'];
    });

    if (newsArticles[index]['isFavorite']) {
      _goToFavoritesPage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${newsArticles[index]['title']} dihapus dari favorit'),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.deepPurple,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berita Sekolah Terkini'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: newsArticles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                final url = newsArticles[index]['url'];
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
                      Icons.article,
                      size: 40,
                      color: Colors.deepPurple,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        newsArticles[index]['title'],
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.deepPurple[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        newsArticles[index]['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                        color: newsArticles[index]['isFavorite'] ? Colors.red : Colors.deepPurple,
                      ),
                      onPressed: () => toggleFavorite(index),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
