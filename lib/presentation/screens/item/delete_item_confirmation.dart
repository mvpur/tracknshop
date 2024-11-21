import 'package:flutter/material.dart';

Future<bool?> showDeleteConfirmationDialog({
  required BuildContext context,
  required String itemName,
}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Are you sure you want to delete "$itemName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), 
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true), 
            child: const Text(
              'Delete',
            ),
          ),
        ],
      );
    },
  );
}
