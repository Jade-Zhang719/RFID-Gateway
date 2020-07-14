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
      selectedDateStyle: Theme.of(context)
          .accentTextTheme
          .bodyText1
          .copyWith(color: Colors.white),
      selectedSingleDateDecoration: BoxDecoration(
        color: Color(0XFFA49F94),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
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
    List<DateTime> eventsDates =
        widget.events?.map<DateTime>((Event e) => e.date)?.toList();
    bool isEventDate = eventsDates?.any((DateTime d) =>
            date.year == d.year &&
            date.month == d.month &&
            d.day == date.day) ??
        false;

    BoxDecoration eventBox = BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor,
      borderRadius: BorderRadius.circular(10),
    );
    TextStyle sundayText = TextStyle(color: Colors.red);

    return EventDecoration(
      boxDecoration: isEventDate ? eventBox : null,
      textStyle: isSunday ? sundayText : null,
    );
  }
}
