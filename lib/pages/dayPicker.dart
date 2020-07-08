import 'package:flutter/material.dart';

import '../src/date_picker_styles.dart';
import '../src/day_picker.dart' as dp;
import '../src/event_decoration.dart';
import '../src/layout_settings.dart';

class CustomDayPicker extends StatefulWidget {
  final double width;
  final double height;
  final ValueChanged onDateChange;

  const CustomDayPicker({Key key, this.width, this.height, this.onDateChange})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomDayPickerState();
}

class _CustomDayPickerState extends State<CustomDayPicker> {
  DateTime _selectedDate;
  DateTime _firstDate;
  DateTime _lastDate;
  double parentwidth;
  double parentheight;

  @override
  void initState() {
    parentwidth = widget.width;
    parentheight = widget.height;
    super.initState();

    _selectedDate = DateTime.now();
    _firstDate = DateTime.now().subtract(Duration(days: 45));
    _lastDate = DateTime.now().add(Duration(days: 45));
  }

  @override
  void didUpdateWidget(CustomDayPicker oldWidget) {
    parentwidth = widget.width;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    DatePickerStyles styles = DatePickerRangeStyles(
        selectedDateStyle: Theme.of(context)
            .accentTextTheme
            .bodyText1
            .copyWith(color: Colors.white),
        selectedSingleDateDecoration: BoxDecoration(
            color: Theme.of(context).primaryColor, shape: BoxShape.rectangle));
    return Container(
      child: dp.DayPicker(
        selectedDate: _selectedDate,
        onChanged: _onSelectedDateChanged,
        firstDate: _firstDate,
        lastDate: _lastDate,
        datePickerStyles: styles,
        datePickerLayoutSettings: DatePickerLayoutSettings(
            dayPickerRowHeight: parentheight * 0.1,
            monthPickerPortraitWidth: parentwidth,
            contentPadding:
                EdgeInsets.symmetric(horizontal: parentwidth * 0.02)),
        eventDecorationBuilder: _sundayDecorationBuilder,
      ),
    );
  }

  void _onSelectedDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      widget.onDateChange(_selectedDate);
    });
  }

  EventDecoration _sundayDecorationBuilder(DateTime date) {
    bool isSunday = date.weekday == 7;
    return isSunday
        ? EventDecoration(textStyle: TextStyle(color: Colors.red))
        : null;
  }
}
