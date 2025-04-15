import 'package:flutter/material.dart';

import '../../../core/app_colors.dart';
import '../tasks/task_view.dart';

class Fab extends StatelessWidget {
  const Fab({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) {
              return const TaskView(
                taskTitleController: null,
                taskDescribtionController: null,
                task: null,
              );
            },
          ),
        );
      },
      child: Material(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 40),
        ),
      ),
    );
  }
}
