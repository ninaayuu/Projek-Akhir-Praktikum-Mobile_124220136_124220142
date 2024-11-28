import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Sekolah di Indonesia',
      home: SekolahList(),
    );
  }
}

class SekolahList extends StatefulWidget {
  @override
  _SekolahListState createState() => _SekolahListState();
}

class _SekolahListState extends State<SekolahList> {
  List<dynamic> sekolahList = [];

  @override
  void initState() {
    super.initState();
    fetchSekolah();
  }

  Future<void> fetchSekolah() async {
    final url = Uri.parse('https://api-sekolah-indonesia.vercel.app/sekolah?page=1&perPage=10');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        sekolahList = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load sekolah');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Sekolah di Indonesia'),
      ),
      body: sekolahList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: sekolahList.length,
              itemBuilder: (context, index) {
                final sekolah = sekolahList[index];
                return ListTile(
                  title: Text(sekolah['sekolah']),
                  subtitle: Text(sekolah['alamat_jalan']),
                );
              },
            ),
    );
  }
}