import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  CurrencyInputFormatter({this.maxDigits});
  final int? maxDigits;
  double? _uMaskValue;

  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    if (maxDigits != null && newValue.selection.baseOffset > maxDigits!) {
      return oldValue;
    }

    double value = double.parse(newValue.text);
    final formatter = new NumberFormat("#,##0");
    _uMaskValue = value;
    String newText = formatter.format(value);
    print(
        '${newValue.copyWith(text: newText + ' ریال ', selection: new TextSelection.collapsed(offset: newText.length))}');
    return newValue.copyWith(
        text: newText + ' ریال ',
        selection: new TextSelection.collapsed(offset: newText.length));
  }

  int getUnmaskedInt() {
    return _uMaskValue!.round();
  }
}
