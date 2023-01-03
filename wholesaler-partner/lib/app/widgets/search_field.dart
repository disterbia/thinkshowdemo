import 'package:flutter/material.dart';
import 'package:wholesaler_user/app/constants/colors.dart';

class SearchField extends StatelessWidget {
  final String hint;
  Function(String) onSubmitted;
  TextEditingController controller;
  SearchField({
    required this.hint,
    required this.onSubmitted,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: (searchText) => onSubmitted(searchText),
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.orange,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
        ),
        isDense: true,
        suffixIcon: InkWell(
          onTap: () => onSubmitted(controller.text),
          child: Icon(
            Icons.search,
            color: MyColors.black,
            size: 26,
          ),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: MyColors.desc, fontSize: 15),
      ),
    );
  }
}
