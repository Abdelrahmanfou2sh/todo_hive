import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo_hive/core/app_colors.dart';
import 'package:todo_hive/core/app_strings.dart';
import 'package:todo_hive/core/base_widget.dart';
import 'package:todo_hive/core/extentions.dart';
import 'package:todo_hive/views/home/tasks/widgets/task_view_app_bar.dart';
import '../../../core/app_constants.dart';
import '../../../models/task.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/time_sclection.dart';

class TaskView extends StatefulWidget {
  const TaskView({
    super.key,
    required this.taskTitleController,
    required this.taskDescribtionController,
    required this.task,
  });

  final TextEditingController? taskTitleController;
  final TextEditingController? taskDescribtionController;
  final Task? task;

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  var title;
  var subTitle;
  DateTime? date;
  DateTime? time;

  String showTime(DateTime? time) {
    if (widget.task?.time == null) {
      if (time == null) {
        return DateFormat('hh:mm a').format(DateTime.now()).toString();
      } else {
        return DateFormat('hh:mm a').format(time).toString();
      }
    } else {
      return DateFormat('hh:mm a').format(widget.task!.time).toString();
    }
  }

  String showDate(DateTime? date) {
    if (widget.task?.date == null) {
      if (date == null) {
        return DateFormat.yMMMEd().format(DateTime.now()).toString();
      } else {
        return DateFormat.yMMMEd().format(date).toString();
      }
    } else {
      return DateFormat.yMMMEd().format(widget.task!.date).toString();
    }
  }

  DateTime showInitialDate(DateTime? date) {
    if (widget.task?.date == null) {
      if (date == null) {
        return DateTime.now();
      } else {
        return date;
      }
    } else {
      return widget.task!.date;
    }
  }

  dynamic isTaskAlreadyExistUpdateOtherWiseCreate() {
    if (widget.taskTitleController?.text != null &&
        widget.taskDescribtionController?.text != null) {
      try {
        widget.taskTitleController?.text = title;
        widget.taskDescribtionController?.text = subTitle;
        widget.task?.save();
        Navigator.pop(context);
      } catch (e) {
        nothingEnterOnUpdateTaskMode(context);
      }
    } else {
      if (title != null && subTitle != null) {
        var task = Task.create(
          title: title,
          description: subTitle,
          date: date,
          time: time,
        );
        BaseWidget.of(context).dataStore.addTask(task: task);
        Navigator.pop(context);
      } else {
        emptyFieldsWarning(context);
      }
    }
  }

  dynamic deleteTask() {
    return widget.task?.delete();
  }

  bool isAlreadyExists() {
    if (widget.taskTitleController?.text == null &&
        widget.taskDescribtionController?.text == null) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
      child: Scaffold(
        appBar: const TaskViewAppBar(),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopText(textTheme),
                _buildTaskAddition(textTheme, context),
                _buildButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment:
            isAlreadyExists()
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
        children: [
          isAlreadyExists()
              ? const SizedBox()
              : MaterialButton(
                onPressed: () {
                  deleteTask();
                  Navigator.pop(context);
                },
                minWidth: 150,
                height: 55,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.close_rounded,
                      color: AppColors.primaryColor,
                    ),
                    const Text(
                      AppStrings.deleteTask,
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
          MaterialButton(
            onPressed: () {
              isTaskAlreadyExistUpdateOtherWiseCreate();
            },
            minWidth: 150,
            height: 55,
            color: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                const Icon(Icons.add_rounded, color: AppColors.primaryColor),
                Text(
                  isAlreadyExists()
                      ? AppStrings.addTaskString
                      : AppStrings.updateTaskString,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskAddition(TextTheme textTheme, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 530,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              AppStrings.titleOfTitleTextField,
              style: textTheme.headlineMedium,
            ),
          ),
          // task title text field
          CustomTextField(
            controller: widget.taskTitleController!,
            onChanged: (String text) {
              title = text;
            },
            onFieldSubmitted: (String text) {
              title = text;
            },
          ),
          10.h,
          CustomTextField(
            controller: widget.taskDescribtionController!,
            isDescribtion: true,
            onChanged: (String subtitle) {
              subTitle = subtitle;
            },
            onFieldSubmitted: (String subtitle) {
              subTitle = subtitle;
            },
          ),
          //
          TimeSelector(
            onTap: () async {
              TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              if (pickedTime != null) {
                setState(() {
                  if (widget.task?.time == null) {
                    time = pickedTime as DateTime?;
                  } else {
                    widget.task?.time = pickedTime as DateTime;
                  }
                });
              }
            },
            title: AppStrings.timeString,
            time: showTime(time),
          ),
          TimeSelector(
            onTap: () {
              DatePicker.showDatePicker(
                context,
                minTime: DateTime.now(),
                maxTime: DateTime(2035, 6, 7),
                onConfirm: (date) {
                  setState(() {
                    if (widget.task?.date == null) {
                      date = date;
                    } else {
                      widget.task?.date = date;
                    }
                  });
                },
              );
            },
            title: AppStrings.dateString,
            time: showDate(date),
            isdate: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTopText(TextTheme textTheme) {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 70, child: Divider(thickness: 2)),
          RichText(
            text: TextSpan(
              text:
                  isAlreadyExists()
                      ? AppStrings.addNewTask
                      : AppStrings.updateCurrentTask,
              style: textTheme.titleLarge,
              children: [
                TextSpan(
                  text: AppStrings.taskStrnig,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(width: 70, child: Divider(thickness: 2)),
        ],
      ),
    );
  }
}
