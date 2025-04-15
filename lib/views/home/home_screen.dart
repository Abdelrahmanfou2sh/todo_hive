import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_hive/core/app_colors.dart';
import 'package:todo_hive/core/app_constants.dart';
import 'package:todo_hive/core/app_strings.dart';
import 'package:todo_hive/core/base_widget.dart';
import 'package:todo_hive/core/extentions.dart';
import 'package:todo_hive/models/task.dart';
import 'package:todo_hive/views/home/widgets/custom_drawer.dart';
import 'package:todo_hive/views/home/widgets/fab.dart';
import 'package:todo_hive/views/home/widgets/home_app_bar.dart';

import 'widgets/task_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<SliderDrawerState> drawerKey = GlobalKey<SliderDrawerState>();

  dynamic valueOfIndicator(List<Task> task) {
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return 3;
    }
  }

  int checkDoneTask(List<Task> task) {
    int i = 0;
    if (task.isNotEmpty) {
      return task.length;
    } else {
      return i;
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final base = BaseWidget.of(context);

    return ValueListenableBuilder(
      valueListenable: base.dataStore.listenToTasks(),
      builder: (ctx, Box<Task> box, Widget? child) {
        var tasks = box.values.toList();
        tasks.sort((a, b) {
          return a.time.compareTo(b.time);
        });

        return Scaffold(
          backgroundColor: Colors.white,
          floatingActionButton: const Fab(),
          body: SliderDrawer(
            key: drawerKey,
            isDraggable: false,
            animationDuration: 1000,
            slider: CustomDrawer(),
            appBar: HomeAppBar(drawerKey: drawerKey),
            child: _buildHomeBody(textTheme, base, tasks),
          ),
        );
      },
    );
  }

  Widget _buildHomeBody(
    TextTheme textTheme,
    BaseWidget base,
    List<Task> tasks,
  ) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          // custom app bar
          Container(
            margin: const EdgeInsets.only(top: 50),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    value: checkDoneTask(tasks) / valueOfIndicator(tasks),
                    color: Colors.grey,
                    valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
                  ),
                ),
                25.w,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.mainTitle, style: textTheme.displayLarge),
                    3.h,
                    Text(
                      '${checkDoneTask(tasks)} of ${tasks.length} task',
                      style: textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
          // divider
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(thickness: 2, indent: 100),
          ),
          // tasks list
          SizedBox(
            width: double.infinity,
            height: 745,
            child:
                tasks.isNotEmpty
                    ? ListView.builder(
                      itemCount: tasks.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var task = tasks[index];
                        return Dismissible(
                          direction: DismissDirection.vertical,
                          onDismissed:
                              (direction) => {
                                base.dataStore.deleteTask(task: task),
                              },
                          background: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.delete, color: Colors.grey),
                              8.w,
                            ],
                          ),
                          key: Key(task.id),
                          child: TaskItem(task: task),
                        );
                      },
                    )
                    // list is empty
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // lottie animation
                        FadeInUp(
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Lottie.asset(
                              lottieURL,
                              animate: tasks.isNotEmpty ? false : true,
                            ),
                          ),
                        ),
                        FadeInUp(
                          from: 30,
                          child: const Text(AppStrings.doneAllTask),
                        ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}
