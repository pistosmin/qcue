import 'package:intl/intl.dart';
import 'dart:async';
import 'package:flutter/material.dart';

Future<dynamic> selectDate(
  BuildContext context,
) async {
  FocusScope.of(context).requestFocus(new FocusNode());
  final DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1901, 1),
      lastDate: new DateTime(2101));
  if (picked != null) {
    return new DateFormat.yMd().format(picked).toString();
  }
}

Future<dynamic> selectTime(BuildContext context, selectedTime) async {
  final TimeOfDay picked =
      await showTimePicker(context: context, initialTime: selectedTime);
  if (picked != null) {
    return picked;
  }
}
