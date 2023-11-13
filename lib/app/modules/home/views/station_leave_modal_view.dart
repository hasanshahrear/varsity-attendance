import 'package:employee_attendance_getx/app/modules/home/controllers/station_leave_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextInputDialog extends StatelessWidget {
  final TextInputDialogController controller = Get.put(TextInputDialogController());

  TextInputDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Purpose '),
      content: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(8.0))
        ),
        child: TextField(
          controller: controller.textController,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Enter reason',
            contentPadding: EdgeInsets.all(8.0), // Padding within the container
            border: InputBorder.none, // Remove the TextField's default border
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(), // Close the dialog
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => controller.saveText(), // Save the entered text
          child: const Text('Save'),
        ),
      ],
    );
  }
}
