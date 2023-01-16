import 'package:dowith/app_theme.dart';
import 'package:dowith/database/database_model.dart';
import 'package:dowith/main.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleEditController = TextEditingController();
  final TextEditingController _contentEditController = TextEditingController();
  final userBox = store.box<DatabaseModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppTheme.nearlyWhite,
        title: const Text(
          "Edit Page",
          style: TextStyle(color: AppTheme.darkerText),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              InputField(
                title: "Title",
                hint: "제목을 입력하세요.",
                multiLine: false,
                controller: _titleEditController,
              ),
              InputField(
                title: "Content",
                hint: "내용을 입력하세요.",
                multiLine: true,
                controller: _contentEditController,
              ),
              ElevatedButton(
                  onPressed: () {
                    List<DatabaseModel> result = userBox.getAll();
                    for (DatabaseModel db in result){
                      print(db.id);
                    }
                  },
                  child: const Text("Submit"))
            ],
          ),
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

  _validateDate() {}

  _addScheduleToDb() {
    final task = DatabaseModel(
        title: _titleEditController.text,
        content: _contentEditController.text,
        state: 0,
        createAt: DateTime.now(),
        startsIn: DateTime.now(),
        expireIn: DateTime.now(),
        completedDate: DateTime.now());
    userBox.put(task);
  }
}
