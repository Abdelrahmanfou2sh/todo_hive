import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/app_colors.dart';
import '../../../models/task.dart';
import '../tasks/task_view.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({super.key, required this.task});

  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescribtionController = TextEditingController();

  @override
  void initState() {
    taskTitleController.text = widget.task.title;
    taskDescribtionController.text = widget.task.description;
    super.initState();
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    taskDescribtionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return TaskView(
                taskTitleController: taskTitleController,
                taskDescribtionController: taskDescribtionController,
                task: widget.task,
              );
            },
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              widget.task.isCompleted
                  ? AppColors.primaryColor.withOpacity(0.1)
                  : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          // check icon
          leading: GestureDetector(
            onTap: () {
              widget.task.isCompleted = !widget.task.isCompleted;
              widget.task.save();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 600),
              decoration: BoxDecoration(
                color:
                    widget.task.isCompleted
                        ? AppColors.primaryColor
                        : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey, width: .8),
              ),
              child: const Icon(Icons.check, color: Colors.white),
            ),
          ),
          // task title
          title: Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 3),
            child: Text(
              taskTitleController.text,
              style: TextStyle(
                color:
                    widget.task.isCompleted
                        ? AppColors.primaryColor
                        : Colors.black,
                fontWeight: FontWeight.w500,
                decoration:
                    widget.task.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
              ),
            ),
          ),
          // task subtitle
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                taskDescribtionController.text,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w300,
                  decoration:
                      widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                ),
              ),
              //task date
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('hh:mm a').format(widget.task.time),
                        style: TextStyle(
                          fontSize: 14,
                          color:
                              widget.task.isCompleted
                                  ? Colors.white
                                  : Colors.grey,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMEd().format(widget.task.date).toString(),
                        style: TextStyle(
                          fontSize: 12,
                          color:
                              widget.task.isCompleted
                                  ? Colors.white
                                  : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
