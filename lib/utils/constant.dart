enum SharedPreferenceKey{
  TAX,
  INVOICE_DAY_RESET,
  INVOICE_COUNTER
}

class DateTimeFormat{
  static const String standard = 'yyyy-MM-dd HH:mm';
  static const String standardNoTime = 'yyyy-MM-dd';
}

class ApiUrl{
  static const baseUrl = 'http://rayhanafif.pythonanywhere.com/';
  static const prediction = '/cashierion';
}