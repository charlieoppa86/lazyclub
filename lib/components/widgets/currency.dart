import 'package:intl/intl.dart';

class DataUtils {
  static final oCcy = NumberFormat("#,###", "ko_KR");
  static String calcStringToWon(String priceString) {
    oCcy.format(int.parse(priceString));
    return "${oCcy.format(int.parse(priceString))}원";
  }
}
