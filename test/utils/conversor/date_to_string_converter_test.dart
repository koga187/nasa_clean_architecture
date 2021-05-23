import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_clean_architecture/core/utils/conversor.dart/date_to_string_converter.dart';

main() {
  test('should convert the date on the string representation mask YYYY-mm-dd',
      () {
    final int year = 2021, month = 02, day = 14;
    final tDate = DateTime(year, month, day);
    final dateStringExpected = '$year-$month-$day';

    expect(dateStringExpected, DateToStringConverter().convert(tDate));
  });
}
