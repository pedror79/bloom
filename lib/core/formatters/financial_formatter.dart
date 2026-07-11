class FinancialFormatter {
  const FinancialFormatter._();

  static String currency(
    double value, {
    int decimalDigits = 0,
  }) {
    final fixedValue = value.toStringAsFixed(decimalDigits);
    final parts = fixedValue.split('.');

    final wholePart = _addThousandsSeparator(parts.first);

    if (decimalDigits == 0) {
      return '$wholePart €';
    }

    final decimalPart = parts.length > 1 ? parts.last : '';

    return '$wholePart,$decimalPart €';
  }

  static String monthlyCurrency(
    double value, {
    int decimalDigits = 0,
  }) {
    return '${currency(value, decimalDigits: decimalDigits)} / mês';
  }

  static String percentage(
    double value, {
    int decimalDigits = 0,
  }) {
    final percentageValue = value * 100;

    return '${percentageValue.toStringAsFixed(decimalDigits)}%';
  }

  static String compactCurrency(double value) {
    final absoluteValue = value.abs();

    if (absoluteValue >= 1000000) {
      final formattedValue = value / 1000000;

      return '${_removeTrailingZero(formattedValue.toStringAsFixed(1))} M€';
    }

    if (absoluteValue >= 1000) {
      final formattedValue = value / 1000;

      return '${_removeTrailingZero(formattedValue.toStringAsFixed(1))} mil €';
    }

    return currency(value);
  }

  static String _addThousandsSeparator(String value) {
    final isNegative = value.startsWith('-');
    final digits = isNegative ? value.substring(1) : value;

    final buffer = StringBuffer();

    for (var index = 0; index < digits.length; index++) {
      final remainingDigits = digits.length - index;

      buffer.write(digits[index]);

      if (remainingDigits > 1 && remainingDigits % 3 == 1) {
        buffer.write(' ');
      }
    }

    final formattedValue = buffer.toString();

    return isNegative ? '-$formattedValue' : formattedValue;
  }

  static String _removeTrailingZero(String value) {
    return value.endsWith('.0')
        ? value.substring(0, value.length - 2)
        : value.replaceAll('.', ',');
  }
}