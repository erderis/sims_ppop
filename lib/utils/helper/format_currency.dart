import 'package:intl/intl.dart';

String formatCurrency(int amount, {String? symbol}) {
  final currencyFormat = NumberFormat.currency(
      locale: 'id_ID', symbol: symbol ?? 'Rp', decimalDigits: 0);
  return currencyFormat.format(amount.toDouble());
}

String unformatCurrency(String formattedCurrency) {
  return formattedCurrency.replaceAll(RegExp(r'[^0-9]'), '');
}
