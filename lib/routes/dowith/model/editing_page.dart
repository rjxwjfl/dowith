import 'package:dowith/app_theme.dart';
import 'package:dowith/database/bloc.dart';
import 'package:dowith/database/db_repository.dart';
import 'package:dowith/database/todo_dao.dart';
import 'package:dowith/database/todo_model.dart';
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
  final Bloc _bloc = Bloc(DBRepository(TodoDao()));
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  TimeOfDay? _startAt;
  TimeOfDay? _expireIn;
  String _startAtString = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String _expireInString = DateFormat("hh:mm a").format(DateTime.now()).toString();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleEditController = TextEditingController();
  final TextEditingController _contentEditController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

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
          child: SingleChildScrollView(
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
                InputField(
                    title: "DatePicker",
                    hint: DateFormat("yyyy년 MM월 dd일").format(_startDate).toString(),
                    multiLine: false,
                    widget: IconButton(
                        onPressed: () {
                          _getDatePicker();
                        },
                        icon: const Icon(Icons.calendar_today))),
                Row(
                  children: [
                    Expanded(
                        child: InputField(
                            title: "Start At",
                            hint: _startAtString,
                            multiLine: false,
                            widget: IconButton(
                                onPressed: () {
                                  _getTimePicker(isStartAt: true);
                                },
                                icon: const Icon(Icons.access_time)))),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: InputField(
                          title: "Expire In",
                          hint: _expireInString,
                          multiLine: false,
                          widget: IconButton(
                              onPressed: () {
                                _getTimePicker(isStartAt: false);
                              },
                              icon: const Icon(Icons.access_time_filled))),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    _addScheduleToDb();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 52,
                    width: 208,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.0), color: AppTheme.nearlyDarkBlue),
                    child: const Center(
                        child: Text(
                      "Submit",
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getDatePicker() async {
    DateTime? pickedDate =
        await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (pickedDate != null) {
      setState(() {
        _startDate = pickedDate;
        print(pickedDate);
      });
    }
  }

  _getTimePicker({required bool isStartAt}) async {
    var pickedTime = await _showTimePicker();
    // ignore: use_build_context_synchronously
    String timeForm = pickedTime.format(context);
    if (pickedTime == null) {
    } else if (isStartAt == true) {
      setState(() {
        _startAt = pickedTime;
        _startAtString = timeForm;
        print(_startAt);
        print(_startAtString);
      });
    } else if (isStartAt == false) {
      setState(() {
        _expireIn = pickedTime;
        _expireInString = timeForm;
        print(_expireIn);
        print(_expireInString);
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startAtString.split(":")[0]), minute: int.parse(_startAtString.split(":")[1].split(" ")[0])));
  }

  _validateDate() {}

  _addScheduleToDb() {
    final task = TodoModel(
        title: _titleEditController.text,
        content: _contentEditController.text,
        state: 0,
        createAt: DateTime.now(),
        startsIn: DateTime.now(),
        expireIn: DateTime.now(),
        completedDate: DateTime.now());
    modelBox.saveTodo(task);
  }
}
