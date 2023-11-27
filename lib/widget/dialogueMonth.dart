// dropdown_dialog.dart

import 'package:flutter/material.dart';

class DropdownDialog extends StatefulWidget {
  @override
  _DropdownDialogState createState() => _DropdownDialogState();
}

class _DropdownDialogState extends State<DropdownDialog> {
  String dropdownValue = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('My Dialog'),
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <String>['Option 1', 'Option 2', 'Option 3']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
      actions: <Widget>[
        TextButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
