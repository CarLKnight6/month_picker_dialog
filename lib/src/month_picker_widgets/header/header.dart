import 'package:flutter/material.dart';

import '/month_picker_dialog.dart';

///The widget that will hold all of the Header widgets.
class PickerHeader extends StatelessWidget {
  const PickerHeader({
    super.key,
    required this.theme,
    required this.localeString,
    required this.isMonthSelector,
    required this.onSelectYear,
    required this.portrait,
    required this.controller,
  });
  final ThemeData theme;
  final String localeString;
  final bool isMonthSelector, portrait;
  final VoidCallback onSelectYear;
  final MonthpickerController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: portrait ? controller.monthPickerDialogSettings.pickerDialogSettings.customWidth : null,
      decoration: BoxDecoration(
        color: controller.headerColor ?? theme.primaryColor,
        borderRadius: portrait
            ? BorderRadius.only(
                topLeft: Radius.circular(controller.monthPickerDialogSettings.pickerDialogSettings.dialogRoundedCornersRadius),
                topRight: Radius.circular(controller.monthPickerDialogSettings.pickerDialogSettings.dialogRoundedCornersRadius),
              )
            : BorderRadius.only(
                topLeft: Radius.circular(controller.monthPickerDialogSettings.pickerDialogSettings.dialogRoundedCornersRadius),
                bottomLeft: Radius.circular(controller.monthPickerDialogSettings.pickerDialogSettings.dialogRoundedCornersRadius),
              ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: controller.hideHeaderRow
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HeaderSelectedDate(
                    theme: theme,
                    localeString: localeString,
                    controller: controller,
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (controller.headerTitle != null) controller.headerTitle!,
                  HeaderSelectedDate(
                    theme: theme,
                    localeString: localeString,
                    controller: controller,
                  ),
                  HeaderRow(
                    theme: theme,
                    localeString: localeString,
                    isMonthSelector: isMonthSelector,
                    onSelectYear: onSelectYear,
                    controller: controller,
                    portrait: portrait,
                  ),
                ],
              ),
      ),
    );
  }
}
