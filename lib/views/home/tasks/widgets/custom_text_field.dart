import 'package:flutter/material.dart';

import '../../../../core/app_strings.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    this.isDescribtion = false,
    required this.onChanged,
    required this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final bool isDescribtion;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListTile(
        title: TextFormField(
          controller: controller,
          maxLines: isDescribtion ? 6 : 2,
          cursorHeight: isDescribtion ? 60 : null,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: isDescribtion ? InputBorder.none : null,
            counter: Container(),
            hintText: isDescribtion ? AppStrings.addNote : null,
            prefixIcon:
                isDescribtion ? const Icon(Icons.bookmark_border) : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
