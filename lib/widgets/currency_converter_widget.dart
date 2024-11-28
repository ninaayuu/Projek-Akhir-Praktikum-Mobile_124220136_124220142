import 'package:flutter/material.dart';

class CurrencyConverterWidget extends StatefulWidget {
  final double amount;
  final String currency;
  final Function(String) onCurrencyChanged;

  CurrencyConverterWidget({
    required this.amount,
    required this.currency,
    required this.onCurrencyChanged,
  });

  @override
  _CurrencyConverterWidgetState createState() => _CurrencyConverterWidgetState();
}

class _CurrencyConverterWidgetState extends State<CurrencyConverterWidget> {
  final List<String> _currencies = ['IDR', 'USD', 'EUR', 'JPY'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Biaya',
              suffixText: widget.currency,
            ),
            enabled: false,
            controller: TextEditingController(
              text: widget.amount.toStringAsFixed(2),
            ),
          ),
        ),
        SizedBox(width: 16),
        DropdownButton<String>(
          value: widget.currency,
          items: _currencies.map((currency) {
            return DropdownMenuItem<String>(
              value: currency,
              child: Text(currency),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              widget.onCurrencyChanged(value);
            }
          },
        ),
      ],
    );
  }
}

