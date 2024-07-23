import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '/month_picker_dialog.dart';

///The main part of the header. Where arrows and current interval are presented.
class HeaderRow extends StatelessWidget {
  const HeaderRow({
    super.key,
    required this.theme,
    required this.localeString,
    required this.isMonthSelector,
    required this.onSelectYear,
    required this.controller,
    required this.portrait,
  });
  final ThemeData theme;
  final String localeString;
  final bool isMonthSelector, portrait;
  final VoidCallback onSelectYear;
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    final TextStyle? headline5 = controller.headerTextColor == null
        ? theme.primaryTextTheme.headlineSmall
        : theme.primaryTextTheme.headlineSmall!
            .copyWith(color: controller.headerTextColor);
    final Color? arrowcolors =
        controller.headerTextColor ?? theme.primaryIconTheme.color;

    final TextScaler? scaler = controller.monthPickerDialogSettings.pickerDialogSettings.textScaleFactor != null
        ? TextScaler.linear(controller.monthPickerDialogSettings.pickerDialogSettings.textScaleFactor!)
        : null;

    final YearUpDownPageProvider yearProvider =
        Provider.of<YearUpDownPageProvider>(context);
    final MonthUpDownPageProvider monthProvider =
        Provider.of<MonthUpDownPageProvider>(context);
    final List<Widget> mainWidgets = isMonthSelector
        ? <Widget>[
            GestureDetector(
              onTap: onSelectYear,
              child: Text(
                DateFormat.y(localeString)
                    .format(DateTime(monthProvider.pageLimit.upLimit)),
                style: headline5,
                textScaler: scaler,
              ),
            ),
            HeaderArrows(
              arrowcolors: arrowcolors,
              onUpButtonPressed: controller.onUpButtonPressed,
              onDownButtonPressed: controller.onDownButtonPressed,
              downState: monthProvider.enableState.downState,
              upState: monthProvider.enableState.upState,
              arrowSize: controller.arrowSize,
              previousIcon: controller.previousIcon,
              nextIcon: controller.nextIcon,
            ),
          ]
        : <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  DateFormat.y(localeString)
                      .format(DateTime(yearProvider.pageLimit.upLimit)),
                  style: headline5,
                  textScaler: scaler,
                ),
                Text(
                  '-',
                  style: headline5,
                  textScaler: scaler,
                ),
                Text(
                  DateFormat.y(localeString)
                      .format(DateTime(yearProvider.pageLimit.downLimit)),
                  style: headline5,
                  textScaler: scaler,
                ),
              ],
            ),
            HeaderArrows(
              arrowcolors: arrowcolors,
              onUpButtonPressed: controller.onUpButtonPressed,
              onDownButtonPressed: controller.onDownButtonPressed,
              downState: yearProvider.enableState.downState,
              upState: yearProvider.enableState.upState,
              arrowSize: controller.arrowSize,
              previousIcon: controller.previousIcon,
              nextIcon: controller.nextIcon,
            ),
          ];
    return portrait
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: mainWidgets,
          )
        : Column(
            children: mainWidgets,
          );
  }
}
