import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SchoolTimeZoneScreen extends StatefulWidget {
  @override
  _SchoolTimeZoneScreenState createState() => _SchoolTimeZoneScreenState();
}

class _SchoolTimeZoneScreenState extends State<SchoolTimeZoneScreen> {
  String _selectedLocation = 'WIB'; 
  String _timeZone = '';
  final Map<String, String> _locations = {
    'WIB': 'Jakarta, Bandung, Sumatra',
    'WITA': 'Bali, Sulawesi, NTB',
    'WIT': 'Papua, Maluku',
    'London': 'London, UK',
  };

  void _updateTimeZone() {
    DateTime now = DateTime.now();
    switch (_selectedLocation) {
      case 'WIB':
        _timeZone = DateFormat('yyyy-MM-dd – kk:mm').format(now.toUtc().add(Duration(hours: 7)));
        break;
      case 'WITA':
        _timeZone = DateFormat('yyyy-MM-dd – kk:mm').format(now.toUtc().add(Duration(hours: 8)));
        break;
      case 'WIT':
        _timeZone = DateFormat('yyyy-MM-dd – kk:mm').format(now.toUtc().add(Duration(hours: 9)));
        break;
      case 'London':
        _timeZone = DateFormat('yyyy-MM-dd – kk:mm').format(now.toUtc().add(Duration(hours: 0))); // GMT
        break;
      default:
        _timeZone = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Zona Waktu Sekolah'),
        backgroundColor: Color(0xFF3F51B5), 
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pilih Zona Waktu:',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F51B5), 
              ),
            ),
            SizedBox(height: 8),
            Container(
              width: double.infinity, 
              padding: EdgeInsets.symmetric(horizontal: 16), 
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF3F51B5), width: 2), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: DropdownButton<String>(
                value: _selectedLocation,
                iconEnabledColor: Color(0xFF3F51B5), 
                underline: SizedBox(), 
                isExpanded: true, 
                items: _locations.keys.map((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(key),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLocation = newValue!;
                    _updateTimeZone();
                  });
                },
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Waktu Lokal:',
              style: TextStyle(
                fontSize: 18, 
                fontWeight: FontWeight.bold,
                color: Color(0xFF3F51B5), 
              ),
            ),
            SizedBox(height: 8),
            Text(
              _timeZone.isNotEmpty ? _timeZone : 'Silakan pilih zona waktu',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87, 
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white, 
    );
  }
} 