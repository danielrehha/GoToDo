import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class TranslateDate {
  static String call({@required DateTime date}) {
    var formatDate = DateFormat.yMMMMd();
    final now = DateTime.now();
    if (now.year == date.year &&
        now.month == date.month &&
        now.day == date.day) {
      return 'Today';
    } else if (now.year == date.year &&
        now.month == date.month &&
        now.day + 1 == date.day) {
      return 'Tomorrow';
    } else {
      return formatDate.format(date).toString();
    }
  }
}
