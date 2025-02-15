import 'package:flutter/material.dart';
import '../utils/type_def.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final InputCallBack callBack;
  const SearchInput(
      {required this.callBack, required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: callBack,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Color(0xff242424),
        hintText: "Search user",
        hintStyle: TextStyle(
          color: Colors.grey,
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
