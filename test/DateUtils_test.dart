import 'package:kronogram/utils/DateUtils.dart';
import 'package:test/test.dart';

void main() {
  group('DateUtils, ', () {
    test('monthToNumber should return correct values', () {
      expect(monthToNumber("Jan"), "01");
      expect(monthToNumber("Feb"), "02");
      expect(monthToNumber("Mar"), "03");
      expect(monthToNumber("Apr"), "04");
      expect(monthToNumber("May"), "05");
      expect(monthToNumber("Jun"), "06");
      expect(monthToNumber("Jul"), "07");
      expect(monthToNumber("Aug"), "08");
      expect(monthToNumber("Sep"), "09");
      expect(monthToNumber("Oct"), "10");
      expect(monthToNumber("Nov"), "11");
      expect(monthToNumber("Dec"), "12");
      expect(monthToNumber("Err"), null);
    });
  });
}
