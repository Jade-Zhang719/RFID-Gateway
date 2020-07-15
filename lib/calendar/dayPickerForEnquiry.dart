import 'package:flutter/material.dart';

import 'event.dart';
import 'src/date_picker_styles.dart';
import 'src/day_picker.dart' as dp;
import 'src/event_decoration.dart';
import 'src/layout_settings.dart';

class CustomDayPicker extends StatefulWidget {
  final double width;
  final double height;
  final ValueChanged onDateChange;
  final List<Event> events;

  const CustomDayPicker(
      {Key key, this.width, this.height, this.onDateChange, this.events})
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
    parentheight = widget.height;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    DatePickerStyles styles = DatePickerRangeStyles(
      currentDateStyle: TextStyle(
        color: Colors.purple[300],
        fontWeight: FontWeight.bold,
      ),
      selectedDateStyle: TextStyle(color: Colors.white),
      selectedSingleDateDecoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0XFFA49F94),
      ),
    );
    return Container(
      child: dp.DayPicker(
        selectedDate: _selectedDate,
        onChanged: _onSelectedDateChanged,
        firstDate: _firstDate,
        lastDate: _lastDate,
        datePickerStyles: styles,
        datePickerLayoutSettings: DatePickerLayoutSettings(
          dayPickerRowHeight: parentheight * 0.125,
          monthPickerPortraitWidth: parentwidth,
          contentPadding: EdgeInsets.symmetric(
            horizontal: parentwidth * 0.01,
            vertical: parentheight * 0.01,
          ),
        ),
        eventDecorationBuilder: _eventDecorationBuilder,
      ),
    );
  }

  void _onSelectedDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      widget.onDateChange(_selectedDate);
    });
  }

  EventDecoration _eventDecorationBuilder(DateTime date) {
    bool isSunday = date.weekday == 7;
    bool isToday = (date.day == DateTime.now().day) &&
        (date.month == DateTime.now().month) &&
        (date.year == DateTime.now().year);

    List<DateTime> eventsDates =
        widget.events?.map<DateTime>((Event e) => e.date)?.toList();
    bool isEventDate = eventsDates?.any((DateTime d) =>
            date.year == d.year &&
            date.month == d.month &&
            d.day == date.day) ??
        false;

    BoxDecoration eventBox = BoxDecoration(
      shape: BoxShape.circle,
      color: isToday
          ? Colors.purple[100]
          : isSunday ? Colors.red[100] : Colors.cyan[100],
    );

    TextStyle eventText = TextStyle(
      color: isToday
          ? Colors.purple[300]
          : isSunday ? Colors.red[300] : Colors.cyan,
      decoration: TextDecoration.underline,
    );

    return EventDecoration(
      boxDecoration: isEventDate ? eventBox : null,
      textStyle: isEventDate
          ? eventText
          : isSunday ? TextStyle(color: Colors.red[300]) : null,
    );
  }
}
