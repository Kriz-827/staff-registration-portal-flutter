import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
        shadowColor: isDarkTheme ? Colors.white : Colors.grey.shade600,
        datePickerTheme: DatePickerThemeData(
            backgroundColor: isDarkTheme ? Colors.grey[700] : Colors.grey[300],
            dayStyle: TextStyle(
                color: isDarkTheme ? Colors.white : Colors.grey.shade600)),
        scaffoldBackgroundColor: isDarkTheme
            ? Colors.grey[800]
            : const Color.fromARGB(255, 237, 237, 237),
        fontFamily: "Platypi",
        primaryColor: Colors.grey.shade400,
        colorScheme: ThemeData().colorScheme.copyWith(
            primary: isDarkTheme ? Colors.white : Colors.grey.shade600,
            secondary: isDarkTheme
                ? Colors.grey[800]
                : const Color.fromARGB(255, 237, 237, 237),
            brightness: isDarkTheme ? Brightness.dark : Brightness.light,
            tertiary: isDarkTheme ? Colors.grey.shade700 : Colors.white),
        cardColor: isDarkTheme ? Colors.grey[400] : Colors.grey[200],
        canvasColor: isDarkTheme ? Colors.grey[600] : Colors.grey[100],
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              colorScheme: isDarkTheme
                  ? const ColorScheme.dark()
                  : const ColorScheme.light(),
            ),
        iconTheme: Theme.of(context).iconTheme.copyWith(
              color: isDarkTheme ? Colors.white : Colors.black,
            ),
        iconButtonTheme: IconButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                    isDarkTheme ? Colors.grey[700] : Colors.grey[100]),
                iconColor: WidgetStatePropertyAll(
                    isDarkTheme ? Colors.grey[200] : Colors.grey[900]))));
  }
}
