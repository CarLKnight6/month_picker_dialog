import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '/month_picker_dialog.dart';
//TODO fix
///The button to be used on the grid of months.
class MonthButton extends StatelessWidget {
  const MonthButton({
    super.key,
    required this.theme,
    required this.localeString,
    required this.onMonthSelected,
    required this.controller,
    required this.date,
  });

  final ThemeData theme;
  final String localeString;
  final ValueChanged<DateTime> onMonthSelected;
  final MonthpickerController controller;
  final DateTime date;

  bool _holdsSelectionPredicate(DateTime mes) {
    if (controller.selectableMonthPredicate != null) {
      return controller.selectableMonthPredicate!(mes);
    } else {
      return true;
    }
  }

  bool _isEnabled(final DateTime mes) {
    if ((controller.localFirstDate == null &&
            (controller.localLastDate == null ||
                (controller.localLastDate != null &&
                    controller.localLastDate!.compareTo(mes) >= 0))) ||
        (controller.localFirstDate != null &&
            ((controller.localLastDate != null &&
                    controller.localFirstDate!.compareTo(mes) <= 0 &&
                    controller.localLastDate!.compareTo(mes) >= 0) ||
                (controller.localLastDate == null &&
                    controller.localFirstDate!.compareTo(mes) <= 0)))) {
      return _holdsSelectionPredicate(mes);
    } else {
      return false;
    }
  }

  /// From the provided color settings,
  /// build the month button style with the default layout
  ///
  /// If not provided, the customization will be built from the app's theme.
  ButtonStyle _buildDefaultMonthStyle() {
    Color? backgroundColor;
    TextStyle? textStyle = controller.monthPickerDialogSettings.buttonsSettings.monthTextStyle ??
        theme.textTheme.labelLarge ??
        const TextStyle(
          fontWeight: FontWeight.bold,
        );
    Color? foregroundColor = controller.monthPickerDialogSettings.buttonsSettings.unselectedMonthsTextColor;
    final List<DateTime> selectedDates = [controller.selectedDate];

    if (controller.rangeMode) {
      if (controller.firstRangeDate != null &&
          controller.secondRangeDate != null) {
        selectedDates
            .addAll([controller.firstRangeDate!, controller.secondRangeDate!]);
        if (date.isAfter(selectedDates[1]) && date.isBefore(selectedDates[2])) {
          backgroundColor = HSLColor.fromColor(
                  controller.monthPickerDialogSettings.buttonsSettings.selectedMonthBackgroundColor ??
                      theme.colorScheme.secondary)
              .withLightness(.7)
              .toColor();
          foregroundColor = theme.textTheme.labelLarge!
              .copyWith(
                color: controller.monthPickerDialogSettings.buttonsSettings.selectedMonthTextColor ??
                    theme.colorScheme.onSecondary,
              )
              .color;
        }
      }
    }

    if (selectedDates.contains(date)) {
      backgroundColor = controller.monthPickerDialogSettings.buttonsSettings.selectedMonthBackgroundColor ??
          theme.colorScheme.secondary;
      foregroundColor = theme.textTheme.labelLarge!
          .copyWith(
            color: controller.monthPickerDialogSettings.buttonsSettings.selectedMonthTextColor ??
                theme.colorScheme.onSecondary,
          )
          .color;
      textStyle = 
          theme.textTheme.labelLarge ??
          TextStyle(
            fontWeight: FontWeight.bold,
            color: foregroundColor,
          );
    } else if (date.month == controller.now.month &&
        date.year == controller.now.year) {
      foregroundColor = controller.monthPickerDialogSettings.buttonsSettings.currentMonthTextColor ?? backgroundColor;
    }

    return TextButton.styleFrom(
      textStyle: textStyle,
      foregroundColor: foregroundColor,
      backgroundColor: backgroundColor,
      shape: controller.monthPickerDialogSettings.buttonsSettings.buttonBorder,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = _isEnabled(date);
    ButtonStyle monthStyle = _buildDefaultMonthStyle();
    final ButtonStyle? Function(DateTime)? monthPredicate =
        controller.monthStylePredicate;
    if (monthPredicate != null) {
      final ButtonStyle? value = monthPredicate(date);
      if (value != null) {
        monthStyle = monthStyle.merge(value);
      }
    }

    return Padding(
      padding: EdgeInsets.all(controller.monthPickerDialogSettings.buttonsSettings.selectedDatePadding),
      child: TextButton(
        onPressed: isEnabled
            ? () => onMonthSelected(DateTime(date.year, date.month))
            : null,
        style: monthStyle,
        child: Text(
          controller.monthPickerDialogSettings.dialogSettings.capitalizeFirstLetter
              ? toBeginningOfSentenceCase(
                  DateFormat.MMM(localeString).format(date))!
              : DateFormat.MMM(localeString).format(date).toLowerCase(),
          style: monthStyle.textStyle?.resolve({}),
          textScaler:
              controller.monthPickerDialogSettings.dialogSettings.textScaleFactor !=
                      null
                  ? TextScaler.linear(controller
                      .monthPickerDialogSettings.dialogSettings.textScaleFactor!)
              : null,
        ),
      ),
    );
  }
}
