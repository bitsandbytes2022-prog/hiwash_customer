
import 'package:intl/intl.dart';

String formatDate(String? dateString) {
  if (dateString == null || dateString.isEmpty) {
    return '';
  }

  DateTime dateTime = DateTime.parse(dateString);
  return DateFormat('d MMM yyyy').format(dateTime);
}