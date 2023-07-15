///Key yang digunakan untuk shared preferences
enum SharedPreferenceKey{
  TAX,
  INVOICE_DAY_RESET,
  INVOICE_COUNTER,
  STORE_NAME,
  PHONE_NUMBER,
  STORE_ADDRESS,
  DESCRIPTION
}

///Format datetime yang digunakan
class DateTimeFormat{
  static const String standard = 'yyyy-MM-dd HH:mm';
  static const String standardNoTime = 'yyyy-MM-dd';
  static const String standardNoTimeNoStripe = 'yyyyMMdd';
}

///URL yang digunakan untuk api
class ApiUrl{
  static const baseUrl = 'http://rayhanafif.pythonanywhere.com/';
  static const prediction = '/cashierion';
}