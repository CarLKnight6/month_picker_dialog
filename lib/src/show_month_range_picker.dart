import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/month_picker_dialog.dart';

/// Displays month picker dialog.
///
/// `initialDate:` is the initially selected month.
///
/// `firstDate:` is the optional lower bound for month selection.
///
/// `lastDate:` is the optional upper bound for month selection.
///
/// `selectableMonthPredicate:` lets you control enabled months just like the official selectableDayPredicate.
///
/// `monthStylePredicate:` allows you to individually customize each month.
///
/// `monthTextStyle:` allows you to customize text-style of month.
///
/// `yearTextStyle:` allows you to customize text-style of year.
///
/// `yearStylePredicate:` allows you to individually customize each year.
///
/// `capitalizeFirstLetter:` lets you control if your months names are capitalized or not.
///
/// `headerColor:` lets you control the calendar header color.
///
/// `headerTextColor:` lets you control the calendar header text and arrows color.
///
/// `selectedMonthBackgroundColor:` lets you control the current selected month/year background color.
///
/// `selectedMonthTextColor:` lets you control the text color of the current selected month/year.
///
/// `unselectedMonthTextColor:` lets you control the text color of the current unselected months/years.
///
/// `currentMonthTextColor:` lets you control the text color of the current month/year.
///
/// `selectedMonthPadding:` lets you control the size of the current selected month/year circle by increasing the padding of it (default is `0`).
///
/// `confirmWidget:` lets you set a custom confirm widget.
///
/// `cancelWidget:` lets you set a custom cancel widget.
///
/// `customHeight:` lets you set a custom height for the calendar widget (default is `240`).
///
/// `customWidth:` lets you set a custom width for the calendar widget (default is `320`).
///
/// `yearFirst:` lets you define that the user must select first the year, then the month.
///
/// `roundedCornersRadius:` lets you define the Radius of the rounded dialog (default is `0`).
///
/// `dismissible:` lets you define if the dialog will be dismissible by clicking outside it.
///
/// `forceSelectedDate:` lets you define that the current selected date will be returned if the user clicks outside of the dialog. Needs `dismissible = true`.
///
/// `animationMilliseconds:` lets you define the speed of the page transition animation (default is `450`).
///
/// `hideHeaderRow:` lets you hide the row with the arrows + years/months page range from the header, forcing the user to scroll to change the page (default is `false`).
///
/// `textScaleFactor:` lets you control the scale of the texts in the widget.
///
/// `arrowSize:` lets you control the size of the header arrows.
///
/// `forcePortrait:` lets you block the widget from entering in landscape mode (default is `false`).
///
/// `customDivider:` lets you add a custom divider between the months/years and the confirm/cancel buttons.
///
/// `blockScrolling:` lets you block the user from scrolling the months/years (default is `true`).
///
/// `dialogBorderSide:` lets you define the border side of the dialog (default is `BorderSide.none`).
///
/// `buttonBorder:` lets you define the border of the month/year buttons (default is `const CircleBorder()`).
///
/// `headerTitle:` lets you add a custom title to the header of the dialog (default is `null`).
///
/// `rangeList:` lets you define if the controller will return the full list of months between the two selected or only them (default is `false`).
///
Future<List<DateTime>?> showMonthRangePicker({
  required BuildContext context,
  TextStyle? monthTextStyle,
  TextStyle? selectedMonthTextStyle,
  TextStyle? yearTextStyle,
  IconData? previousIcon,
  IconData? nextIcon,
  DateTime? initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
  bool Function(DateTime)? selectableMonthPredicate,
  ButtonStyle? Function(DateTime)? monthStylePredicate,
  ButtonStyle? Function(int)? yearStylePredicate,
  Color? headerColor,
  Color? headerTextColor,
  Color? selectedMonthBackgroundColor,
  Color? selectedMonthTextColor,
  Color? unselectedMonthTextColor,
  Color? currentMonthTextColor,
  double selectedMonthPadding = 0,
  Widget? confirmWidget,
  Widget? cancelWidget,
  bool hideHeaderRow = false,
  double? arrowSize,
  Widget? customDivider,
  OutlinedBorder buttonBorder = const CircleBorder(),
  Widget? headerTitle,
  bool rangeList = false,
  MonthPickerDialogSettings monthPickerDialogSettings =
      defaultMonthPickerDialogSettings,
}) async {
  final ThemeData theme = Theme.of(context);
  final MonthpickerController controller = MonthpickerController(
    monthTextStyle: monthTextStyle,
    selectedMonthTextStyle: selectedMonthTextStyle,
    yearTextStyle: yearTextStyle,
    previousIcon: previousIcon,
    nextIcon: nextIcon,
    initialDate: initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    selectableMonthPredicate: selectableMonthPredicate,
    monthStylePredicate: monthStylePredicate,
    yearStylePredicate: yearStylePredicate,
    headerColor: headerColor,
    headerTextColor: headerTextColor,
    selectedMonthBackgroundColor: selectedMonthBackgroundColor,
    selectedMonthTextColor: selectedMonthTextColor,
    unselectedMonthTextColor: unselectedMonthTextColor,
    currentMonthTextColor: currentMonthTextColor,
    selectedMonthPadding: selectedMonthPadding,
    confirmWidget: confirmWidget,
    cancelWidget: cancelWidget,
    hideHeaderRow: hideHeaderRow,
    theme: theme,
    useMaterial3: theme.useMaterial3,
    arrowSize: arrowSize,
    customDivider: customDivider,
    buttonBorder: buttonBorder,
    headerTitle: headerTitle,
    rangeMode: true,
    rangeList: rangeList, 
    monthPickerDialogSettings: monthPickerDialogSettings,
  );
  final List<DateTime>? dialogDate = await showDialog<List<DateTime>>(
    context: context,
    barrierDismissible: monthPickerDialogSettings.pickerDialogSettings.dismissible,
    builder: (BuildContext context) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: YearUpDownPageProvider(),
          ),
          ChangeNotifierProvider.value(
            value: MonthUpDownPageProvider(),
          ),
        ],
        child: MonthPickerDialog(controller: controller),
      );
    },
  );
  if (monthPickerDialogSettings.pickerDialogSettings.dismissible && monthPickerDialogSettings.pickerDialogSettings.forceSelectedDate && dialogDate == null) {
    return [controller.selectedDate];
  }
  return dialogDate;
}
