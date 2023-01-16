import 'package:dowith/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'input_field.dart';

class EditingPage extends StatefulWidget {
  const EditingPage({Key? key}) : super(key: key);

  @override
  State<EditingPage> createState() => _EditingPageState();
}

class _EditingPageState extends State<EditingPage> {
  DateTime _selectDate = DateTime.now();
  String _startAt = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _expireIn = DateFormat("hh:mm a").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppTheme.nearlyWhite,
        title: const Text("Edit Page", style: TextStyle(color: AppTheme.darkerText),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          children: const <Widget>[
            InputField(title: "Title", hint: "1st Item", multiLine: false,),
            InputField(title: "Subject", hint: "2st Item", multiLine: false,),
            InputField(title: "Content", hint: "3st Item", multiLine: true,),
          ],
        ),
      ),
    );
  }

  _getDatePicker() async {
    DateTime? _pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (_pickedDate != null) {
      setState(() {
        _selectDate = _pickedDate;
      });
    }
  }

  _getTimePicker({required bool isStartAt}) async {
    var _pickedTime = await _showTimePicker();
    // ignore: use_build_context_synchronously
    String timeForm = _pickedTime.format(context);
    if (_pickedTime == null) {
    } else if (isStartAt == true) {
      setState(() {
        _startAt = timeForm;
      });
    } else if (isStartAt == false) {
      setState(() {
        _expireIn = timeForm;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.dialOnly,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startAt.split(":")[0]),
            minute: int.parse(_startAt.split(":")[1].split(" ")[0])));
  }
}
