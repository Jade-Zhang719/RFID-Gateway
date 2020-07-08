import 'package:flutter/material.dart';

import 'semantic_sorting.dart';

class MonthNavigationRow extends StatelessWidget {
  final Key previousPageIconKey;
  final Key nextPageIconKey;
  final VoidCallback onNextMonthTapped;
  final VoidCallback onPreviousMonthTapped;
  final String nextMonthTooltip;
  final String previousMonthTooltip;

  /// Usually [Text] widget.
  final Widget title;

  const MonthNavigationRow(
      {Key key,
      this.previousPageIconKey,
      this.nextPageIconKey,
      this.onNextMonthTapped,
      this.onPreviousMonthTapped,
      this.nextMonthTooltip,
      this.previousMonthTooltip,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Semantics(
              sortKey: MonthPickerSortKey.previousMonth,
              child: IconButton(
                key: previousPageIconKey,
                icon: Icon(Icons.chevron_left),
                tooltip: previousMonthTooltip,
                onPressed: onPreviousMonthTapped,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              alignment: Alignment.center,
              child: ExcludeSemantics(
                child: title,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Semantics(
              sortKey: MonthPickerSortKey.nextMonth,
              child: IconButton(
                key: nextPageIconKey,
                icon: Icon(Icons.chevron_right),
                tooltip: nextMonthTooltip,
                onPressed: onNextMonthTapped,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
