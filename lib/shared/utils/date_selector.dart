
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class  DateSelector{
  static Future<void> selectDate(
      BuildContext context,
      TextEditingController dobController,
      ValueNotifier<DateTime> selectedDateNotifier,
      ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: selectedDateNotifier.value,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year - 18),
    );
    if (picked != null && picked != selectedDateNotifier.value) {
      selectedDateNotifier.value = picked;
      dobController.text = DateFormat('dd/MM/yyyy').format(
        selectedDateNotifier.value,
      );
    }
  }
}

