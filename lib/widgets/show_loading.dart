import 'package:flutter/material.dart';

void showLoading(context, [String? text]) {
  late final _colorScheme = Theme.of(context).colorScheme;
  String text1 = text ?? "Loading...";
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            decoration: BoxDecoration(color: _colorScheme.surfaceContainer, borderRadius: BorderRadius.circular(8.0), boxShadow: [
              //阴影
              BoxShadow(
                color: _colorScheme.shadow,
                //offset: Offset(2.0,2.0),
                blurRadius: 10.0,
              )
            ]),
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(16),
            constraints: BoxConstraints(minHeight: 120, minWidth: 180),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    text1,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ),
        );
      });
}

void hideLoading(BuildContext context) {
  Navigator.of(context).pop();
}
