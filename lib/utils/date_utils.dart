const _monthToNumberMap = {
  'Jan': '01',
  'Feb': '02',
  'Mar': '03',
  'Apr': '04',
  'May': '05',
  'Jun': '06',
  'Jul': '07',
  'Aug': '08',
  'Sep': '09',
  'Oct': '10',
  'Nov': '11',
  'Dec': '12'
};

const _numberToMonthMap = {
  '1' : 'Jan',
  '2' : 'Feb',
  '3' : 'Mar',
  '4' : 'Apr',
  '5' : 'May',
  '6' : 'Jun',
  '7' : 'Jul',
  '8' : 'Aug',
  '9' : 'Sep',
  '10' : 'Oct',
  '11' : 'Nov',
  '12' : 'Dec'
};

String monthToNumber(String month) {
  return _monthToNumberMap[month];
}

/// Takes in a Twitter creation time [String] in the format
/// "Thu Feb 27 22:20:44 +0000 2020" and returns a [DateTime] object.
DateTime parseTwitterCreationTime(String createdAt) {
  if(createdAt == null) return null;
  // Should give us a list of size 6.
  List<String> splitted = createdAt.split(" ");

  // splitted[0] gives the weekday, while splitted[4] gives us a timezone difference.
  // We don't need the weekday, and since twitter always gives a UTC timestamp,
  // we don't need the timezone either.

  String month = monthToNumber(splitted[1]);
  String day = splitted[2];
  String time = splitted[3];
  String year = splitted[5];

  var buffer = new StringBuffer();
  buffer.write(year);
  buffer.write('-');
  buffer.write(month);
  buffer.write('-');
  buffer.write(day);
  buffer.write(' ');
  buffer.write(time);
  DateTime date = DateTime.parse(buffer.toString());
  return new DateTime.utc(
      date.year, date.month, date.day, date.hour, date.minute, date.second);
}

/// Takes in an Instagram creation time [String] and returns
/// a [DateTime] object.
DateTime parseInstagramCreationTime(String createdAt) {
  DateTime date = DateTime.parse(createdAt);
  return new DateTime.utc(
      date.year, date.month, date.day, date.hour, date.minute, date.second);
}

String getDateString(DateTime date) {
  String month = _numberToMonthMap[date.month.toString()];
  return month + ' ' + date.day.toString() + ', ' + date.toLocal().year.toString();
}