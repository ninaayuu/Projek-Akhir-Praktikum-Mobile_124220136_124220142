import 'package:flutter/material.dart';

class EducationCostScreen extends StatefulWidget {
  @override
  _EducationCostScreenState createState() => _EducationCostScreenState();
}

class _EducationCostScreenState extends State<EducationCostScreen> {
  double _tuitionFee = 0.0;
  double _uniformCost = 0.0;
  double _bookCost = 0.0;
  double _extracurricularCost = 0.0;
  String _totalCostText = '';
  String _selectedLevel = 'SD';
  String _selectedCurrency = 'IDR'; // Default to IDR for no conversion

  final Map<String, double> _conversionRates = {
    'IDR': 1.0,       // Default conversion for IDR
    'USD': 0.000066,  // 1 IDR to USD
    'EUR': 0.000061,  // 1 IDR to EUR
    'JPY': 0.0098,    // 1 IDR to JPY
    'GBP': 0.000052,  // 1 IDR to GBP
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biaya Pendidikan'),
        backgroundColor: Color(0xFF3F51B5),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pilih Tingkat Pendidikan:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F51B5),
                ),
              ),
              Row(
                children: [
                  _buildRadioTile('SD'),
                  _buildRadioTile('SMP'),
                  _buildRadioTile('SMA'),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Biaya Pendidikan:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3F51B5)),
              ),
              SizedBox(height: 8),
              _buildCostTextField('Biaya Pendidikan', (value) {
                setState(() {
                  _tuitionFee = double.tryParse(value) ?? 0.0;
                });
              }),
              SizedBox(height: 16),
              Text(
                'Biaya Tambahan:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3F51B5)),
              ),
              SizedBox(height: 8),
              _buildCostTextField('Seragam', (value) {
                setState(() {
                  _uniformCost = double.tryParse(value) ?? 0.0;
                });
              }),
              SizedBox(height: 8),
              _buildCostTextField('Buku', (value) {
                setState(() {
                  _bookCost = double.tryParse(value) ?? 0.0;
                });
              }),
              SizedBox(height: 8),
              _buildCostTextField('Ekstrakurikuler', (value) {
                setState(() {
                  _extracurricularCost = double.tryParse(value) ?? 0.0;
                });
              }),
              SizedBox(height: 16),
              Text(
                'Pilih Mata Uang:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3F51B5)),
              ),
              SizedBox(height: 8),
              DropdownButton<String>(
                value: _selectedCurrency,
                items: _conversionRates.keys.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCurrency = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    _calculateTotalCost();
                  },
                  child: Text(
                    'Hitung Biaya Pendidikan',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3F51B5),
                    padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                _totalCostText,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRadioTile(String level) {
    return Expanded(
      child: RadioListTile<String>(
        title: Text(level),
        value: level,
        groupValue: _selectedLevel,
        onChanged: (value) {
          setState(() {
            _selectedLevel = value!;
          });
        },
      ),
    );
  }

  Widget _buildCostTextField(String label, ValueChanged<String> onChanged) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black54),
        suffixText: 'IDR',
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF3F51B5)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onChanged: onChanged,
    );
  }

  void _calculateTotalCost() {
    double totalCostInIDR =
        _tuitionFee + _uniformCost + _bookCost + _extracurricularCost;

    double conversionRate = _conversionRates[_selectedCurrency]!;
    double convertedCost = totalCostInIDR * conversionRate;

    setState(() {
      _totalCostText =
          'Total dalam IDR: ${totalCostInIDR.toStringAsFixed(2)}\n'
          'Total dalam $_selectedCurrency: ${convertedCost.toStringAsFixed(2)}';
    });
  }
}