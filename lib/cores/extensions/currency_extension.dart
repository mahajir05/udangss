import 'package:intl/intl.dart';

extension NumCurrencyExtension on num {
  String? toIdr({bool isShorten = false}) {
    String val = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(this);
    if (isShorten == true) {
      var valueSplited = val.split('.');
      if (valueSplited.length > 2) {
        valueSplited.removeLast();
        val = '${valueSplited.join('.')} k';
      }
    }
    return val;
  }
}

extension StringCurrencyExtension on String? {
  String toIdr() {
    var parsed = double.tryParse(this ?? '');
    if (parsed == null) {
      return this ?? '';
    }
    return NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0).format(parsed);
  }
}
