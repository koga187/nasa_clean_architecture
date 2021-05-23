class DateToStringConverter {
  String convert(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
