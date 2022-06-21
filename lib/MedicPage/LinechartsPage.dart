import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:loginpage/MedicPage/statcontroller.dart';
import 'package:google_fonts/google_fonts.dart';


class LineCharts extends StatefulWidget {
  const LineCharts({ Key? key }) : super(key: key);

  @override
  State<LineCharts> createState() => _LineChartsState();
}

class _LineChartsState extends State<LineCharts> {
  var statController = Get.put(StatController());
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
      )
    );
  }

  Widget _buildGraphStat() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      _buildSectionTitle('Primera Seccion', 'unit'),
      Obx(
        () => _buildWeekIndicators(statController.dailyStatList1.call(),1)
      ),
      Padding(
        padding: const EdgeInsets.only(top: 8),
      ),
    ],
  );
  }

  Widget _pageIndicatorText() {
    return Obx(()=> Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.pink,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Text(statController.currentWeek.value,
            style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),
        )
      )
    ));
  }

  Widget _previousWeekButton() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: RawMaterialButton(
          onPressed: () {
            statController.onPreviousWeek();
          },
          elevation: 2,
          fillColor: Colors.pink,
          child: Icon(Icons.arrow_back, color:Colors.white),
          padding: EdgeInsets.all(8),
          shape: CircleBorder(),
        )
      )
    );
  }

  Widget _nextWeekButton() {
    return Obx(() => Visibility(
      visible: statController.displayNextWeekBtn.value,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: RawMaterialButton(
            onPressed: () {
              statController.onNextWeek();
            },
            elevation: 2,
            fillColor: Colors.pink,
            child: Icon(Icons.arrow_forward, color: Colors.white),
            padding: EdgeInsets.all(8),
            shape: CircleBorder(),
          )
        ),
      )
      ) 
    );
  }

  Widget _buildSectionTitle(String title, String subTitle) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold))
          ),
          Text(subTitle, style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold))
        ],
      )
    );
  }

  Widget _buildWeekIndicators(List<DailyStatUiModel> models, int type){
    if(models.length == 7) {
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
          )
        )
      );
    } else {
      return Container();
    }
  }

  Widget _buildDayIndicator(DailyStatUiModel model, int type) {
    
    return InkWell(
      onTap: () => statController.setSelectedDayPosition(model.dayPosition, type),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 48, 
            height: 24,
            child: Visibility(
              visible: model.isSelected,
              child: DecoratedBox(
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                child: Center(child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Text('${model.stat} uni', 
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
                  )
                ))
              )
            )
          ),
          SizedBox(height: 4),
          Expanded(
            child: NeumorphicIndicator(
              width: 25,
              percent: statController.getStatPercentage(model.stat, type),
            )
          ),
          SizedBox(height: 8),
          DecoratedBox(
            decoration: _getDayDecoratedBox(model.isToday),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(model.day)
            ),
          )
        ],
      )
    );
  }

  _getDayDecoratedBox(bool isToday) {
    if(isToday) {
      return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        color: Colors.pink,
      );
    } else {
      return BoxDecoration();
    }
  }

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
  accentColor: kAccentColor,
  splashColor: kLightestGrey,
  highlightColor: kLightGrey,
  scaffoldBackgroundColor: kBaseColor,
  textTheme: _textTheme,
  iconTheme: IconThemeData(
    color: kDefaultTextColor,
  ),
);

final _textTheme = GoogleFonts.kanitTextTheme(TextTheme(
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

final neumorphicTheme = NeumorphicThemeData(
    defaultTextColor: Color(0xFF30475E),
    accentColor: Color(0xFFF05454),
    variantColor: Color(0xFFFFA45B),
    baseColor: Color(0xFFE8E8E8),
    depth: 10,
    intensity: 0.6,
    lightSource: LightSource.topLeft);




