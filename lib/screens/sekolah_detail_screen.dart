import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projek_mobile/models/school_model.dart';

class SekolahDetailScreen extends StatefulWidget {
  final String npsn;

  SekolahDetailScreen({required this.npsn});

  @override
  _SekolahDetailScreenState createState() => _SekolahDetailScreenState();
}

class _SekolahDetailScreenState extends State<SekolahDetailScreen> {
  late School _sekolahData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSekolahData();
  }

  Future<void> _fetchSekolahData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api-sekolah-indonesia.vercel.app/sekolah?npsn=${widget.npsn}'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _sekolahData = School.fromJson(data['dataSekolah'][0]);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load sekolah data');
      }
    } catch (e) {
      print('Error fetching sekolah data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sekolah Detail'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade100, Colors.deepPurple.shade50],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 5,
                shadowColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          _sekolahData.sekolah,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(color: Colors.deepPurple),
                      SizedBox(height: 16),
                      _buildDetailRow('NPSN:', _sekolahData.npsn),
                      _buildDetailRow('Jenjang:', _sekolahData.bentuk),
                      _buildDetailRow('Propinsi:', _sekolahData.propinsi),
                      _buildDetailRow('Kabupaten/Kota:', _sekolahData.kabupaten_kota),
                      _buildDetailRow('Kecamatan:', _sekolahData.kecamatan),
                      _buildDetailRow('Alamat:', _sekolahData.alamat_jalan),
                      _buildDetailRow(
                          'Koordinat:', '(${_sekolahData.lintang}, ${_sekolahData.bujur})'),
                      _buildDetailRow('Status:', _sekolahData.status),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
