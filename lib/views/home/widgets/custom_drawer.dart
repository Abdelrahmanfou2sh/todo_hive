import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_hive/core/app_colors.dart';
import 'package:todo_hive/core/extentions.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final List<IconData> icons = [
    CupertinoIcons.home,
    CupertinoIcons.person_fill,
    CupertinoIcons.settings,
    CupertinoIcons.info_circle_fill,
  ];

  final List<String> titles = ["Home", "Profile", "Settings", "Details"];

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 90),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.primaryGradientColor,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://avatars.githubusercontent.com/u/91388754?v=4',
            ),
          ),
          8.h,
          Text('Fou2sh', style: textTheme.displayMedium),
          Text("Footballer", style: textTheme.displaySmall),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            width: double.infinity,
            height: 300,
            child: ListView.builder(
              itemCount: icons.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Handle navigation or action here
                  },
                  child: Container(
                    margin: const EdgeInsets.all(3),
                    child: ListTile(
                      leading: Icon(
                        icons[index],
                        size: 30,
                        color: Colors.white,
                      ),
                      title: Text(
                        titles[index],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
