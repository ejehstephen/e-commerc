import 'package:intl/intl.dart';

class PriceFormatter {
  static String format(double price) {
    final formatCurrency = NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    );
    return formatCurrency.format(price);
  }
}
