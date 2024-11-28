import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:projek_mobile/models/sekolah.dart';

class SekolahService {
  static Future<List<Sekolah>> getSekolah({required int page, required int perPage}) async {
    final url = Uri.parse('https://api-sekolah-indonesia.vercel.app/sekolah?page=$page&perPage=$perPage');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['dataSekolah'] as List<dynamic>;
      return data.map((item) => Sekolah.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load sekolah');
    }
  }
}