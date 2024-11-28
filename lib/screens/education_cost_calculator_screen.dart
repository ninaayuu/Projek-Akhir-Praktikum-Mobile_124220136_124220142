import 'package:flutter/material.dart';
import '../widgets/currency_converter_widget.dart';

class EducationCostCalculatorScreen extends StatefulWidget {
  @override
  _EducationCostCalculatorScreenState createState() => _EducationCostCalculatorScreenState();
}

class _EducationCostCalculatorScreenState extends State<EducationCostCalculatorScreen> {
  double _tuitionFee = 0.0;
  double _uniformCost = 0.0;
  double _bookCost = 0.0;
  double _extracurricularCost = 0.0;
  String _currency = 'IDR';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kalkulator Biaya Pendidikan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Biaya Pendidikan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            CurrencyConverterWidget(
              amount: _tuitionFee,
              currency: _currency,
              onCurrencyChanged: (currency) {
                setState(() {
                  _currency = currency;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Biaya Tambahan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Seragam',
                suffixText: _currency,
              ),
              onChanged: (value) {
                setState(() {
                  _uniformCost = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Buku',
                suffixText: _currency,
              ),
              onChanged: (value) {
                setState(() {
                  _bookCost = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 8),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ekstrakurikuler',
                suffixText: _currency,
              ),
              onChanged: (value) {
                setState(() {
                  _extracurricularCost = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to calculate the total cost
              },
              child: Text('Hitung Biaya Pendidikan'),
            ),
          ],
        ),
      ),
    );
  }
}