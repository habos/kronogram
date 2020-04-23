import 'package:kronogram/utils/date_utils.dart';
import 'package:test/test.dart';

void main() {
  group('DateUtils, ', () {
    /// Tests that our monthToNumber function correctly converts
    /// the three-letter representation of a given month
    /// to the correct numeric value.
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

    /// Tests that our parsing function correctly converts the string representation
    /// of a timestamp into the native Dart format DateTime.
    test('parseTwitterCreationTime should parse Twitter timestamps correctly',
        () {
      String createdAtA = "Thu Feb 27 22:20:44 +0000 2020";
      String createdAtB = "Sat Dec 22 10:24:12 +0700 2010";
      DateTime actualA = parseTwitterCreationTime(createdAtA);
      DateTime expectedA = new DateTime.utc(2020, 2, 27, 22, 20, 44);
      DateTime actualB = parseTwitterCreationTime(createdAtB);
      DateTime expectedB = new DateTime.utc(2010, 12, 22, 10, 24, 12);

      expect(actualA.isAtSameMomentAs(expectedA), isTrue);
      expect(actualB.isAtSameMomentAs(expectedB), isTrue);
      expect(actualA.isAtSameMomentAs(expectedB), isFalse);
      expect(actualB.isAtSameMomentAs(expectedA), isFalse);
    });

    test('parseInstagramCreationTime should parse Instagram timestamps correctly', () {
      String createdAtA = "1997-07-16T19:20:30+00:00";
      String createdAtB = "2020-03-31T12:22:02+00:00";
      DateTime actualA = parseInstagramCreationTime(createdAtA);
      DateTime expectedA = new DateTime.utc(1997, 7, 16, 19, 20, 30);
      DateTime actualB = parseInstagramCreationTime(createdAtB);
      DateTime expectedB = new DateTime.utc(2020, 3, 31, 12, 22, 2);

      expect(actualA.isAtSameMomentAs(expectedA), isTrue);
      expect(actualB.isAtSameMomentAs(expectedB), isTrue);
      expect(actualA.isAtSameMomentAs(expectedB), isFalse);
      expect(actualB.isAtSameMomentAs(expectedA), isFalse);
    });
  });
}
