import 'package:intl/intl.dart';

extension StringX on String {
  String firstCapital() => toBeginningOfSentenceCase(this.toLowerCase())!;
}
