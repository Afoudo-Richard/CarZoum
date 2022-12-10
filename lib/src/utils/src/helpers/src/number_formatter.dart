import 'package:money_formatter/money_formatter.dart';

extension NumberFormatter on num {
  String formatNumber({
    String? symbol = 'FCFA',
    String thousandSeparator = ',',
  }) {
    return MoneyFormatter(
      amount: toDouble(),
      settings: MoneyFormatterSettings(
        symbol: symbol,
        thousandSeparator: thousandSeparator,
        symbolAndNumberSeparator: ' ',
        fractionDigits: 0,
      ),
    ).output.symbolOnLeft;
  }
}
