import 'package:intl/intl.dart';

class FormatDate {
  final DateTime rawDate;

  FormatDate(this.rawDate);

  String get date => formatMyDate();

  String formatMyDate() {
    var formatDate = DateFormat.yMMMMd();
    var formatHour = DateFormat.Hm();
    return "${formatDate.format(DateTime.now()).toString()} @${formatHour.format(rawDate)}";
  }
}
