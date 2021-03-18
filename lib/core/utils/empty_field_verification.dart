import 'package:meta/meta.dart';

class EmptyFieldVerification {
  bool call({@required String value}) => value.isNotEmpty ? true : false;
}
