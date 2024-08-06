import 'package:flutter/material.dart';
import 'package:todoapp/util/material_button.dart';

class DialogBox extends StatelessWidget {
  final dialogBoxController;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  DialogBox(
      {super.key,
      required this.dialogBoxController,
      required this.onSave,
      required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: const EdgeInsets.all(5),
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: dialogBoxController,
              decoration: const InputDecoration(
                hintText: "Add new task",
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MatButton(text: 'Save', onPressed: onSave),
                MatButton(text: 'Cancel', onPressed: onCancel),
              ],
            )
          ],
        ),
      ),
      backgroundColor: Colors.grey[300],
    );
  }
}
