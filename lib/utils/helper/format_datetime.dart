import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final formattedDate =
      DateFormat('dd MMMM yyyy   HH:mm').format(dateTime.toLocal());
  return '$formattedDate WIB';
}
