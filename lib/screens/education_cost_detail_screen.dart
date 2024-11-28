import 'package:flutter/material.dart';
import '../models/education_cost.dart';
import '../widgets/currency_converter_widget.dart';

class EducationCostDetailScreen extends StatelessWidget {
  final EducationCost cost;

  EducationCostDetailScreen({required this.cost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biaya Pendidikan ${cost.educationLevel}'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Biaya Pendidikan Rata-rata:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            CurrencyConverterWidget(
              amount: cost.averageCost,
              currency: cost.currency, onCurrencyChanged: (String ) {  },
            ),
            SizedBox(height: 16),
            Text(
              'Biaya Tambahan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Seragam: ${cost.uniformCost}'),
                SizedBox(height: 4),
                Text('Buku: ${cost.bookCost}'),
                SizedBox(height: 4),
                Text('Ekstrakurikuler: ${cost.extracurricularCost}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}