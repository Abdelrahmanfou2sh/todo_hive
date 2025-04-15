import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:todo_hive/core/app_constants.dart';
import 'package:todo_hive/core/base_widget.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({super.key, required this.drawerKey});
  final GlobalKey<SliderDrawerState>? drawerKey;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool isOpen = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleDrawer() {
    setState(() {
      isOpen = !isOpen;
      if (isOpen) {
        controller.forward();
        widget.drawerKey!.currentState?.openSlider();
      } else {
        controller.reverse();
        widget.drawerKey!.currentState?.closeSlider();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var base = BaseWidget.of(context).dataStore.box;
    return SizedBox(
      width: double.infinity,
      height: 130,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: toggleDrawer,
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: controller,
                  size: 30,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                onPressed: () {
                  base.isEmpty
                      ? warningNoTask(context)
                      : deleteAllTask(context);
                },
                icon: const Icon(CupertinoIcons.trash_fill, size: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
