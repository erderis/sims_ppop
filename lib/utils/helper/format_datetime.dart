import 'package:intl/intl.dart';

String formatDateTime(String dateTimeString) {
  final dateTime = DateTime.parse(dateTimeString);
  final formattedDate = DateFormat('dd MMMM yyyy   HH:mm').format(dateTime);
  return '$formattedDate WIB';
}
