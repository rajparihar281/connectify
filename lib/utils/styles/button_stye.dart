import 'package:flutter/material.dart';

ButtonStyle customOutLineStyle() {
  return ButtonStyle(
      shape: WidgetStateProperty.all(RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  )));
}
