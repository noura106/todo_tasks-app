import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class AddDate extends StatefulWidget {
   AddDate({super.key});

  @override
  State<AddDate> createState() => _AddDateState();
}

class _AddDateState extends State<AddDate> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: _selectedDate,
        selectedTextColor: Colors.white,
        dateTextStyle: AppTheme.bodyText1,
        monthTextStyle: AppTheme.headline2,
        dayTextStyle: AppTheme.headline2,
        selectionColor: AppColors.primaryMidBarColor.withOpacity(0.2),
        onDateChange: (newDate) {
          setState(() {
            _selectedDate = newDate;
          });
        },
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.1,
    );
  }
}
