String formatDate(DateTime date) {
  return "${date.day}-${date.month}-${date.year}";
}

DateTime formatDateTime(DateTime date) {
  return DateTime.parse(date.toString().substring(0, 10));
}
