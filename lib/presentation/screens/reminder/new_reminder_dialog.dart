import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:track_shop_app/entities/reminder.dart';
import 'package:track_shop_app/presentation/provider/reminder_provider.dart';
import 'package:track_shop_app/presentation/widgets/utils/snackbar.dart';
import 'package:track_shop_app/helper/reminder_helper.dart';

class NewReminderDialog extends ConsumerStatefulWidget {
  static const String name = 'new_reminder_dialog';

  final String title;
  final String? description;

  const NewReminderDialog({super.key, required this.title, this.description});

  @override
  _NewReminderDialogState createState() => _NewReminderDialogState();
}

class _NewReminderDialogState extends ConsumerState<NewReminderDialog> {
  final TextEditingController bodyController;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  _NewReminderDialogState() : bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.description != null) {
      bodyController.text = widget.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'New Reminder',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: bodyController, // Controlador con valor inicial
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Reminder Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text("Date: ${selectedDate.toLocal().toString().split(' ')[0]}"),
                onTap: _selectDate,
              ),
              ListTile(
                leading: const Icon(Icons.access_time),
                title: Text("Time: ${selectedTime.format(context)}"),
                onTap: _selectTime,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: _saveReminder,
                    child: const Text('Set Reminder'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Seleccionar hora
  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  Future<void> _saveReminder() async {
    if (bodyController.text.isEmpty) {
      SnackbarUtil.showSnackbar(
        context,
        'Please fill in the body.',
        backgroundColor: Colors.red,
      );
      return;
    }

    final DateTime reminderDateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (reminderDateTime.isBefore(DateTime.now())) {
      SnackbarUtil.showSnackbar(
        context,
        'The reminder date must be in the future.',
        backgroundColor: Colors.red,
      );
      return;
    }

    final Reminder newReminder = await ReminderHelper.scheduledNotification(
      title: widget.title,
      body: bodyController.text,
      scheduledDate: reminderDateTime,
    );

    final reminder = ref.watch(reminderProvider.notifier);

    reminder.addReminder(newReminder);

    Navigator.of(context).pop();
  }
}
