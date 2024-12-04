import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:projek_mobile/screens/education_cost_screen.dart';
import 'package:projek_mobile/screens/sekolah_list_screen.dart';
import 'package:projek_mobile/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Supabase.instance.client.auth.currentUser;

    return MaterialApp(
      title: 'Daftar Sekolah di Indonesia',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: user != null
          ? SekolahListScreen(username: user.email ?? 'Pengguna') // Menggunakan email sebagai username
          : LoginScreen(),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://itlqnlecmsyoysjehwgv.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0bHFubGVjbXN5b3lzamVod2d2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE5OTE2MzAsImV4cCI6MjA0NzU2NzYzMH0.s5E13vf5YTCt4dXwUtnqyNSDXxzH7yYxgrzQ9JH0eP8',
  );

  runApp(MyApp());
}