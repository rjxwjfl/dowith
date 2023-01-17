import 'package:dowith/app_theme.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({required this.title,
    required this.hint,
    this.controller,
    this.widget,
    required this.multiLine,
    Key? key})
      : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final bool multiLine;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 6.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.darkerText),
          ),
          Container(
            height: multiLine ? 202 : 52,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14, right: 14),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              crossAxisAlignment: multiLine? CrossAxisAlignment.start : CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextFormField(
                    minLines: 1,
                    maxLines: multiLine ? 25 : 1,
                    keyboardType: multiLine ? TextInputType.multiline : null,
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: hint,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0,
                        ),
                      ),
                    ),
                    onSaved: (value){

                    },
                  ),
                ),
                widget == null ? Container() : Container(child: widget),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
