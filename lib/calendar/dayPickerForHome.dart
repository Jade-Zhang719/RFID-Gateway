import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';

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
        color: Theme.of(context).primaryColor,
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
    List<DateTime> eventsDates =
        widget.events?.map<DateTime>((Event e) => e.date)?.toList();
    bool isEventDate = eventsDates?.any((DateTime d) =>
            newDate.year == d.year &&
            newDate.month == d.month &&
            newDate.day == d.day) ??
        false;

    setState(() {
      _selectedDate = newDate;
      widget.onDateChange(_selectedDate);
      dismissAllToast();
      if (isEventDate) {
        Event event;
        widget.events.forEach((element) {
          DateTime d = element.date;
          if (newDate.year == d.year &&
              newDate.month == d.month &&
              newDate.day == d.day) {
            event = element;
          }
        });

        showToastWidget(
          Row(
            children: [
              Container(
                width: parentwidth * 0.4,
                height: parentheight * 0.5,
                margin: EdgeInsets.only(
                  left: parentwidth * 0.48,
                  bottom: parentheight * 0.35,
                ),
                padding: EdgeInsets.all(parentwidth * 0.01),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: parentwidth * 0.01,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Text(
                        event.dis,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            dismissAllToast();
                          },
                          child: Container(
                            child: Text(
                              "Close",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          position: ToastPosition.bottom,
          duration: Duration(seconds: 10),
          handleTouch: true,
        );
      }
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
