import 'dart:convert';
import 'dart:core';

import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/storage/storage_handler.dart';
import 'package:QuickDo/core/utils/tools.dart';
import 'package:QuickDo/core/widgets/buttons/main_elevated_button.dart';
import 'package:QuickDo/core/widgets/images/custom_image.dart';
import 'package:QuickDo/core/widgets/text_fields/input_fields.dart';
import 'package:QuickDo/features/auth/data/models/login_model.dart';
import 'package:QuickDo/features/tasks/data/models/task_model.dart';
import 'package:QuickDo/features/tasks/presentation/controllers/task_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(Duration(minutes: 15)))
      .toString();
  int _selectedRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String _selectedRepeat = 'None';
  List<String> repeatList = ['None', 'Dealy', 'Weekly', 'Monthly'];
  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homePageTest,
      appBar: _appBar(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: AppTheme.headline6,
              ),
              InputField(
                title: 'Title',
                hint: 'Enter Title here',
                controller: _titleController,
              ),
              InputField(
                title: 'Note',
                hint: 'Enter Note here',
                controller: _noteController,
              ),
              InputField(
                title: 'Date',
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                  onPressed: () {
                    _getDateFromUser();
                  },
                  icon: const Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey,
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: 'Start Time',
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputField(
                      title: 'End Time',
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(
                          Icons.access_time_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InputField(
                  title: 'Reminder',
                  hint: '$_selectedRemind minutes early',
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        items: remindList
                            .map<DropdownMenuItem<String>>(
                                (value) =>
                                DropdownMenuItem<String>(
                                    value: value.toString(),
                                    child: Text(
                                      '$value',
                                      style:
                                      const TextStyle(color: Colors.white),
                                    )))
                            .toList(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 32,
                          color: Colors.grey,
                        ),
                        elevation: 4,
                        underline: Container(
                          height: 0,
                        ),
                        style: AppTheme.headline2,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedRemind = int.parse(newValue!);
                          });
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  )),
              InputField(
                  title: 'Repeat',
                  hint: _selectedRepeat,
                  widget: Row(
                    children: [
                      DropdownButton(
                        dropdownColor: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        items: repeatList
                            .map<DropdownMenuItem<String>>(
                                (String value) =>
                                DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style:
                                      const TextStyle(color: Colors.white),
                                    )))
                            .toList(),
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          size: 32,
                          color: Colors.grey,
                        ),
                        elevation: 4,
                        underline: Container(
                          height: 0,
                        ),
                        style: AppTheme.headline2,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedRepeat = newValue!;
                          });
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 18,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  MainElevatedButton(
                    onPressed: () {
                      _validateDate();
                    },
                    text: 'Create Task',
                    defaultWidth: false,
                    isSmall: true,
                    widthRatio: 4,
                    textMargin: EdgeInsets.symmetric(horizontal: 10),
                    height: 35,)

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() =>
      AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 30,
            color: AppColors.primaryColor,
          ),
        ),
        elevation: 0,
        backgroundColor: AppColors.homePageTest,
      );

  _validateDate() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTasksToDb();
      Navigator.of(context).pop();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Tool.showToast('All fields are required', context);
    } else {
      print('SomeThing Bad Happened');
    }
  }

  _addTasksToDb() async {
    try {
      int value = await Provider.of<TaskController>(context, listen: false)
          .addTask(
          task: Task(
              title: _titleController.text,
              note: _noteController.text,
              isCompleted: 0,
              date: DateFormat.yMd().format(_selectedDate),
              startTime: _startTime,
              endTime: _endTime,
              color: _selectedColor,
              remind: _selectedRemind,
              repeat: _selectedRepeat));
      print('$value');
    } catch (e) {
      print('error');
    }
  }

  Column _colorPallete() {
    return Column(
      children: [
        Text(
          'Color',
          style: AppTheme.bodyText1,
        ),
        const SizedBox(
          height: 8,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
                (index) =>
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedColor = index;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      child: _selectedColor == index
                          ? const Icon(
                        Icons.done,
                        size: 16,
                        color: Colors.white,
                      )
                          : null,
                      backgroundColor: index == 0
                          ? AppColors.bluishClr
                          : index == 1
                          ? AppColors.pinkClr
                          : AppColors.orangeClr,
                      radius: 14,
                    ),
                  ),
                ),
          ),
        ),
      ],
    );
  }

  Future<void> _getTimeFromUser({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
        DateTime.now().add(const Duration(minutes: 15)),
      ),
    );
    String _formattedime = _pickedTime!.format(context);
    if (isStartTime) {
      setState(() {
        _startTime = _formattedime;
      });
    }
    else if (!isStartTime) {
      setState(() {
        _endTime = _formattedime;
      });
    }
    else {
      print('Time canceled or something is wrong');
    }
  }

  void _getDateFromUser() async {
    DateTime? _pickedDate = await showDatePicker(

      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015),
      lastDate: DateTime(2030),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    } else {
      print('It\'s null or something is wrong');
    }
  }
}
