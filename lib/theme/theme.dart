import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0.0,
      surfaceTintColor: Colors.black,
    ),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      // ignore: deprecated_member_use
      background: Colors.black,
      // ignore: deprecated_member_use
      onBackground: Colors.white,
      surfaceTint: Colors.black12,
      primary: Colors.white,
      onPrimary: Colors.black,
    ),
    navigationBarTheme: const NavigationBarThemeData(
      height: 55,
      indicatorColor: Colors.transparent,
      elevation: 5.0,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      backgroundColor: Colors.black,
      // ignore: deprecated_member_use
      iconTheme: MaterialStatePropertyAll<IconThemeData>(
        IconThemeData(
          color: Colors.white,
          size: 30,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        // ignore: deprecated_member_use
        backgroundColor: MaterialStateProperty.all(Colors.white),
        // ignore: deprecated_member_use
        foregroundColor: MaterialStateProperty.all(Colors.black),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
      // ignore: deprecated_member_use
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Colors.transparent),
        ),
      ),
      backgroundColor:
          // ignore: deprecated_member_use
          MaterialStateProperty.all<Color>(const Color(0xff242424)),
      // ignore: deprecated_member_use
      minimumSize: MaterialStateProperty.all(Size.zero),
      // ignore: deprecated_member_use
      padding: MaterialStateProperty.all<EdgeInsets>(
        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      ),
    )));
