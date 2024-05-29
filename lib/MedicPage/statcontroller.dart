
/*class StatController extends GetxController {
  RxString todayStat = "".obs;
  RxString currentWeek = "".obs;

  RxList<DailyStatUiModel> dailyStatList1 = (List<DailyStatUiModel>.of([])).obs;

  RxBool displayNextWeekBtn = false.obs;

  double maxSection1 = -1;

  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();

  @override
  void onInit() {
    setCurrentWeek();
  }

  void resetMaxValue() {
    maxSection1 = -1;
  }

  void setCurrentWeek() async {
    selectedDate = DateTime.now();
    currentWeek.value = getWeekDisplayDate(selectedDate);
    getDailyStatList(selectedDate);
  }

  void setPreviousWeek() {
    selectedDate = selectedDate.subtract(Duration(days: 7));
    setNextWeekButtonVisibility();
    currentWeek.value = getWeekDisplayDate(selectedDate);
    getDailyStatList(selectedDate);
  }

  void setNextWeek() {
    selectedDate = selectedDate.add(Duration(days: 7));
    setNextWeekButtonVisibility();
    currentWeek.value = getWeekDisplayDate(selectedDate);
    getDailyStatList(selectedDate);
  }

  void setNextWeekButtonVisibility() {
    displayNextWeekBtn.value = !selectedDate.isSameDate(currentDate);
  }

  String getWeekDisplayDate(DateTime dateTime) {
    return '${AppDateUtils.firstDateOfWeek(dateTime).toFormatString('dd MMM')} - ${AppDateUtils.lastDateOfWeek(dateTime).toFormatString('dd MMM')}';
  }

  Future<void> getDailyStatList(DateTime dateTime) async {
    resetMaxValue();
    var daysInWeek = AppDateUtils.getDaysInWeek(dateTime);

    List<DailyStatUiModel> section1Stat = List.filled(7, defaultDailyStat);
    var today = DateTime.now();
    //String formatted = DateFormat.yMd().format(today);
    var todayPosition = DateTime.now().weekday - 1;
    double valordia = 10;
    dynamic resultant = await fechaval().Getvals();

    for (var i = 0; i <= 6; i++) {
      //List itemslist = [10, 37, 28, 56, 19, 47, 67];
      var date = daysInWeek[i];
      var randomStat1 = randomInt(100);
      section1Stat[i] = DailyStatUiModel(
          day: date.toFormatString('EEE'),
          stat: randomStat1,
          isToday: today.isSameDate(date),
          isSelected: todayPosition == i,
          dayPosition: i);

      if (maxSection1 < randomStat1) {
        maxSection1 = randomStat1;
      }

      dailyStatList1.assignAll(section1Stat);
    }
  }

  double randomInt(double max) {
    return Random().nextInt(100).toDouble() + 1;
  }

  void setSelectedDayPosition(int position, int sectionNumber) {
    switch (sectionNumber) {
      case 1:
        {
          dailyStatList1.assignAll(getDailyListWithSelectedDay(
            dailyStatList1.call(),
            position,
          ));
          break;
        }
    }
  }

  List<DailyStatUiModel> getDailyListWithSelectedDay(
      List<DailyStatUiModel> list, int position) {
    return list
        .map((e) => e.copyWith(isSelected: e.dayPosition == position))
        .toList();
  }

  double getStatPercentage(double time, int type) {
    switch (type) {
      case 1:
        {
          return getSection1StatPercentage(time);
        }
      default:
        return 0.0;
    }
  }

  double getSection1StatPercentage(double time) {
    if (time == 0) {
      return 0;
    } else {
      return time / maxSection1;
    }
  }

  void onNextWeek() {
    setNextWeek();
  }

  void onPreviousWeek() {
    setPreviousWeek();
  }
}

class AppDateUtils {
  static DateTime firstDateOfWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  static DateTime lastDateOfWeek(DateTime dateTime) {
    return dateTime
        .add(Duration(days: DateTime.daysPerWeek - dateTime.weekday));
  }

  static List<DateTime> getDaysInWeek(DateTime dateTime) {
    var days = List<DateTime>.filled(7, DateTime.fromMillisecondsSinceEpoch(0));
    var firstDay = firstDateOfWeek(dateTime);
    for (var i = 0; i <= 6; i++) {
      days[i] = firstDay.add(Duration(days: i));
    }
    return days;
  }
}

extension DateExtension on DateTime {
  String toFormatString(String format) => DateFormat(format).format(this);

  bool isSameDate(DateTime other) {
    return this.year == other.year &&
        this.month == other.month &&
        this.day == other.day;
  }
}

var defaultDailyStat = DailyStatUiModel(
  day: 'day',
  stat: 0,
  isToday: false,
  isSelected: false,
  dayPosition: 1,
);

class DailyStatUiModel {
  String day;
  double stat;
  bool isToday;
  bool isSelected;
  int dayPosition;

  DailyStatUiModel(
      {required this.day,
      required this.stat,
      required this.isToday,
      required this.isSelected,
      required this.dayPosition});

  DailyStatUiModel copyWith(
          {String? day,
          double? stat,
          bool? isToday,
          bool? isSelected,
          int? dayPosition}) =>
      DailyStatUiModel(
          day: day ?? this.day,
          stat: stat ?? this.stat,
          isToday: isToday ?? this.isToday,
          isSelected: isSelected ?? this.isSelected,
          dayPosition: dayPosition ?? this.dayPosition);
}*/
