// custom_bottom_sheet.dart
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final VoidCallback onSubmit;
  final IconData icon;
  final int maxLines;
  final double fontSize;

  const CustomBottomSheet({
    super.key,
    required this.hintText,
    required this.labelText,
    required this.controller,
    required this.onSubmit,
    required this.icon,
    this.maxLines = 4,
    this.fontSize = 21,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: Colors.transparent,
        child: Container(
          height: 230,
          decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, top: 25.0, right: 15, bottom: 30),
            child: ListView(
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        textInputAction: TextInputAction.newline,
                        maxLines: maxLines,
                        style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w400),
                        autofocus: true,
                        decoration: InputDecoration(hintText: hintText, labelText: labelText, labelStyle: const TextStyle(color: Colors.indigoAccent, fontWeight: FontWeight.w500)),
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return 'Empty description!';
                          }
                          return value != null && value.contains('@') ? 'Do not use the @ char.' : null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, top: 15),
                      child: CircleAvatar(
                        backgroundColor: Colors.indigoAccent,
                        radius: 18,
                        child: IconButton(
                          icon: Icon(
                            icon,
                            size: 22,
                            color: Colors.white,
                          ),
                          onPressed: onSubmit,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
