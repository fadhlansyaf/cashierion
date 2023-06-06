class FunctionHelper{
  ///Jika showZero = true return X.XXX,XX, Jika showZero = false jika comma = 00, return X.XXX, else return X.XXX,XX
  static String convertPriceWithComma(num price, [bool showZero = false]) {
    String initPrice = price.toStringAsFixed(2);
    String tempPrice = initPrice.substring(0, initPrice.length - 3);
    int x = (tempPrice.length) % 3;
    String comma = initPrice.substring(initPrice.length - 2, initPrice.length);
    if (x == 0) {
      x = 3;
    }
    int interval = 3;
    if (tempPrice.length > 3) {
      String data = tempPrice.substring(0, x);
      for (int i = x; i < tempPrice.length; i += interval) {
        if (i == tempPrice.length - 4) {
          break;
        }
        data += ".${tempPrice.substring(i, i + interval)}";
      }
      if (!showZero && comma == '00') {
        return 'Rp $data';
      } else {
        return 'Rp $data,$comma';
      }
    } else {
      if (!showZero && comma == '00') {
        return 'Rp $tempPrice';
      } else {
        return 'Rp $tempPrice,$comma';
      }
    }
  }
}