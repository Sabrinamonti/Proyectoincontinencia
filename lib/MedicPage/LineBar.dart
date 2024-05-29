import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../backend/CodeEjercicio1.dart';

class LineBar extends StatefulWidget {
  final String value;
  const LineBar({Key? key, required this.value}) : super(key: key);

  @override
  State<LineBar> createState() => _LineBarState();
}

class _LineBarState extends State<LineBar> {
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
    selectedDate = selectedDate.subtract(const Duration(days: 7));
    setNextWeekButtonVisibility();
    currentWeek.value = getWeekDisplayDate(selectedDate);
    getDailyStatList(selectedDate);
  }

  void setNextWeek() {
    selectedDate = selectedDate.add(const Duration(days: 7));
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

  Future<void> getDailyStatList(DateTime dateTime) async {
    resetMaxValue();
    var daysInWeek = AppDateUtils.getDaysInWeek(dateTime);

    List<DailyStatUiModel> section1Stat = List.filled(7, defaultDailyStat);
    var today = DateTime.now();
    var todayPosition = DateTime.now().weekday - 1;
    double valordia = 10;
    dynamic resultant = await fechaval().Getvals();

    for (var i = 0; i <= 6; i++) {
      List valores = [3.65, 2.67, 8.87, 4.67, 8.76, 5.67, 2.67];
      double data = 0;
      var date = daysInWeek[i];
      var randomStat1 = randomInt(100);
      var datetime = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + i);
      String formatted = DateFormat.yMd().format(datetime);
      final docsval = FirebaseFirestore.instance
          .collection('sensor')
          .doc('1HLQ1EncUCX8aNYsUXnS7HpKv963')
          .collection('Ejercicio')
          .doc('sensor')
          .collection('valormax')
          .where('fecha', isEqualTo: formatted)
          .get()
          .then((value) => {
                value.docs.forEach((element) {
                  setState(() {
                    data = element.data()['emg'];
                  });
                })
              });
      section1Stat[i] = DailyStatUiModel(
          day: date.toFormatString('EEE'),
          stat: valores[i],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        SingleChildScrollView(
          child: _buildGraphStat(),
        ),
        _pageIndicatorText(),
        _previousWeekButton(),
        _nextWeekButton(),
      ],
    ));
  }

  Widget _buildGraphStat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildSectionTitle('Primera Seccion', 'unit'),
        Obx(() => _buildWeekIndicators(dailyStatList1.call(), 1)),
        const Padding(
          padding: EdgeInsets.only(top: 8),
        ),
      ],
    );
  }

  Widget _pageIndicatorText() {
    return Obx(() => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
            padding: const EdgeInsets.all(16),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.pink,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  currentWeek.value,
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ))));
  }

  Widget _previousWeekButton() {
    return Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: RawMaterialButton(
              onPressed: () {
                onPreviousWeek();
              },
              elevation: 2,
              fillColor: Colors.pink,
              child: const Icon(Icons.arrow_back, color: Colors.white),
              padding: const EdgeInsets.all(8),
              shape: const CircleBorder(),
            )));
  }

  Widget _nextWeekButton() {
    return Obx(() => Visibility(
        visible: displayNextWeekBtn.value,
        child: Align(
          alignment: Alignment.bottomRight,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: RawMaterialButton(
                onPressed: () {
                  onNextWeek();
                },
                elevation: 2,
                fillColor: Colors.pink,
                child: const Icon(Icons.arrow_forward, color: Colors.white),
                padding: const EdgeInsets.all(8),
                shape: const CircleBorder(),
              )),
        )));
  }

  Widget _buildSectionTitle(String title, String subTitle) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
                child: Text(title,
                    style:
                        const TextStyle(fontSize: 23, fontWeight: FontWeight.bold))),
            Text(subTitle,
                style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold))
          ],
        ));
  }

  Widget _buildWeekIndicators(List<DailyStatUiModel> models, int type) {
    if (models.length == 7) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: SizedBox(
              height: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDayIndicator(models[0], type),
                  _buildDayIndicator(models[1], type),
                  _buildDayIndicator(models[2], type),
                  _buildDayIndicator(models[3], type),
                  _buildDayIndicator(models[4], type),
                  _buildDayIndicator(models[5], type),
                  _buildDayIndicator(models[6], type),
                ],
              )));
    } else {
      return Container();
    }
  }

  Widget _buildDayIndicator(DailyStatUiModel model, int type) {
    return InkWell(
        onTap: () => setSelectedDayPosition(model.dayPosition, type),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                width: 48,
                height: 24,
                child: Visibility(
                    visible: model.isSelected,
                    child: DecoratedBox(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                child: Text(
                                  '${model.stat} uni',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )))))),
            const SizedBox(height: 4),
            Expanded(
                child: NeumorphicIndicator(
              width: 25,
              percent: getStatPercentage(model.stat, type),
            )),
            const SizedBox(height: 8),
            DecoratedBox(
              decoration: _getDayDecoratedBox(model.isToday),
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(model.day)),
            )
          ],
        ));
  }

  _getDayDecoratedBox(bool isToday) {
    if (isToday) {
      return const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.pink,
      );
    } else {
      return const BoxDecoration();
    }
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
    return year == other.year &&
        month == other.month &&
        day == other.day;
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
}

const Color kDarkGrey = Color(0xff393b44);
const Color kLightGrey = Color(0xff8d93ab);
const Color kLightestGrey = Color(0xffd6e0f0);
const Color kLightText = Color(0xfff1f3f8);
const Color kDefaultTextColor = Color(0xFF30475E);
const Color kAlphaTextColor = Color(0x3230475E);
const Color kAlphaPrimary80 = Color(0xCC30475E);
const Color kAccentColor = Color(0xFFF05454);
const Color kIndicatorAccentColor = Color(0xFFFF4646);
const Color kIndicatorAccentVariantColor = Color(0xFFFF8585);
const Color kVariantColor = Color(0xFF222831);
const Color kBaseColor = Color(0xFFE8E8E8);

final ThemeData appThemeData = ThemeData(
  primaryColor: kDefaultTextColor,
  splashColor: kLightestGrey,
  highlightColor: kLightGrey,
  scaffoldBackgroundColor: kBaseColor,
  textTheme: _textTheme,
  iconTheme: const IconThemeData(
    color: kDefaultTextColor,
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
);

final _textTheme = GoogleFonts.kanitTextTheme(const TextTheme(
  headline1: TextStyle(
      fontSize: 34, fontWeight: FontWeight.bold, color: kDefaultTextColor),
  headline2: TextStyle(
      fontSize: 28, fontWeight: FontWeight.bold, color: kDefaultTextColor),
  headline3: TextStyle(
      fontSize: 24, fontWeight: FontWeight.normal, color: kDefaultTextColor),
  bodyText1: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  ),
));

const neumorphicTheme = NeumorphicThemeData(
    defaultTextColor: Color(0xFF30475E),
    accentColor: Color(0xFFF05454),
    variantColor: Color(0xFFFFA45B),
    baseColor: Color(0xFFE8E8E8),
    depth: 10,
    intensity: 0.6,
    lightSource: LightSource.topLeft);
