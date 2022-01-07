import 'package:flutter/material.dart';

class LoadingDialog {
  static void show(BuildContext context) async {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new SimpleDialog(elevation: 0, backgroundColor: Colors.transparent, children: <Widget>[Center(child: CircularProgressIndicator())]);
        });
  }
}
